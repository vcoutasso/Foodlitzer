import Foundation

protocol NearbyPlacesServiceProtocol {
    func getNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlace]
}

final class NearbyPlacesService: GetRequestService<RequestResponse<GooglePlace>>, NearbyPlacesServiceProtocol {
    // MARK: - Properties

    static let placesURL: String = #"https://maps.googleapis.com/maps/api/place/nearbysearch/json?"#

    var apiKey: String!

    // MARK: - Constants

    private let nearbyRadius: Int = 5000
    private let placeType: String = "restaurant"

    // MARK: - Object lifecycle

    convenience init() {
        self.init(from: NearbyPlacesService.placesURL, with: JSONDecoder())!
        retrieveAPIKey()
    }

    private override init(from baseURL: URL, with decoder: JSONDecoding) {
        super.init(from: baseURL, with: decoder)
    }

    private override init?(from link: String, with decoder: JSONDecoding) {
        super.init(from: link, with: decoder)
    }

    // MARK: - Public methods

    func getNearbyPlaces(latitude: String, longitude: String) async -> [GooglePlace] {
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
