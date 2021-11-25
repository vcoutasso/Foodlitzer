import Foundation

protocol NearbyPlacesServiceProtocol {
    func fetchNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlaceDTO]
}

// TODO: Composition over inheritance
final class NearbyPlacesService: GetRequestService<RequestResponse<GooglePlaceDTO>>, NearbyPlacesServiceProtocol {
    // MARK: - Properties

    static let placesLink: String = #"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"#

    var apiKey: String!

    // MARK: - Constants

    private let nearbyRadius: Int
    private let placeType: String

    // MARK: - Object lifecycle

    convenience init(for type: String = "restaurant",
                     within radius: Int = 5000,
                     with decoder: JSONDecoding = JSONDecoder()) {
        self.init(from: NearbyPlacesService.placesLink, for: type, within: radius, with: decoder)!
        retrieveAPIKey()
    }

    private init(from baseURL: URL, for type: String, within radius: Int, with decoder: JSONDecoding) {
        self.placeType = type
        self.nearbyRadius = radius
        super.init(from: baseURL, with: decoder)
    }

    private init?(from link: String, for type: String, within radius: Int, with decoder: JSONDecoding) {
        self.placeType = type
        self.nearbyRadius = radius
        super.init(from: link, with: decoder)
    }

    // MARK: - Public methods

    func fetchNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlaceDTO] {
        addQueryItem(name: "location", value: "\(latitude),\(longitude)")
        addQueryItem(name: "radius", value: String(nearbyRadius))
        addQueryItem(name: "type", value: placeType)
        addQueryItem(name: "key", value: apiKey)

        let result = await makeRequest()

        switch result {
        case let .success(response):
            return response.results
        case let .failure(error):
            debugPrint("Get nearby places error: \(error.localizedDescription)")
            return []
        }
    }

    func retrieveAPIKey() {
        guard let path = Bundle.main.path(forResource: Strings.GooglePlaces.infoFilename,
                                          ofType: Strings.GooglePlaces.infoFileExtension),
            let plistContent = NSDictionary(contentsOfFile: path),
            let placesAPIKey = plistContent[Strings.GooglePlaces.apiKey] as? String else { return }

        apiKey = placesAPIKey
    }
}
