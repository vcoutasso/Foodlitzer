import Foundation

protocol NearbyPlacesServiceProtocol {
    func fetchNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlaceDTO]
}

final class NearbyPlacesService: NearbyPlacesServiceProtocol {
    // MARK: - Class Properties

    static let placesLink: String = #"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"#

    // MARK: - Instance Properties

    private let nearbyRadius: Int
    private let placeType: String
    private var apiKey: String!

    // MARK: - Dependencies

    private let getRequestService: GetRequestService<RequestResponse<GooglePlaceDTO>>

    // MARK: - Object lifecycle

    convenience init(for type: String = "restaurant",
                     within radius: Int = 5000,
                     with decoder: JSONDecoding = JSONDecoder()) {
        self.init(from: NearbyPlacesService.placesLink, for: type, within: radius, with: decoder)!
        retrieveAPIKey()
    }

    private init?(from link: String, for type: String, within radius: Int, with decoder: JSONDecoding) {
        self.placeType = type
        self.nearbyRadius = radius
        self.getRequestService = .init(from: link, with: decoder)!
    }

    // MARK: - Public methods

    func fetchNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlaceDTO] {
        getRequestService.addQueryItem(name: "location", value: "\(latitude),\(longitude)")
        getRequestService.addQueryItem(name: "radius", value: String(nearbyRadius))
        getRequestService.addQueryItem(name: "type", value: placeType)
        getRequestService.addQueryItem(name: "key", value: apiKey)

        let result = await getRequestService.makeRequest()

        switch result {
        case let .success(response):
            return response.results
        case let .failure(error):
            debugPrint("Fetch nearby places error: \(error.localizedDescription)")
            return []
        }
    }

    // TODO: Storing secrets in plist files is not safe, find a better alternative
    private func retrieveAPIKey() {
        guard let path = Bundle.main.path(forResource: Strings.GooglePlaces.infoFilename,
                                          ofType: Strings.GooglePlaces.infoFileExtension),
            let plistContent = NSDictionary(contentsOfFile: path),
            let placesAPIKey = plistContent[Strings.GooglePlaces.apiKey] as? String else { return }

        apiKey = placesAPIKey
    }
}
