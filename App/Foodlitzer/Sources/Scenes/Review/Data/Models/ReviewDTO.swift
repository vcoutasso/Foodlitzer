import Foundation

struct ReviewDTO: Codable {
    let restaurantID: String
    let ambientLighting: Float
    let waitingTime: Float
    let ambientNoise: Float
    let userTags: [String]
    let userRating: Int
}
