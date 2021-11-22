struct GooglePlaceDTO: Decodable {
    let placeID: String?
    let name: String?
    let rating: Float?
    let totalRatings: Int?
    let types: [String]?
    let address: String?
    let priceLevel: Int?

    // MARK: - Inner types

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case totalRatings = "user_ratings_total"
        case priceLevel = "price_level"
        case address = "vicinity"

        case name
        case rating
        case types
    }
}
