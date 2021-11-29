import FirebaseFirestoreSwift

struct RestaurantInfoDTO: Codable {
    @DocumentID var id: String?
    let name: String
    let rating: Float
    let totalRatings: Int
    let address: String
    let priceLevel: Int
}

struct RestaurantImageDTO: Codable {
    @DocumentID var id: String?
    let imageData: Data
}

struct RestaurantVideoDTO: Codable {
    @DocumentID var id: String?
    let url: URL
    let videoData: Data?
}

struct RestaurantReviewDTO: Codable {
    @DocumentID var id: String?
    let restaurantID: String
    let ambientLighting: Float
    let waitingTime: Float
    let ambientNoise: Float
    let userTags: [String]
    let userRating: Int
}
