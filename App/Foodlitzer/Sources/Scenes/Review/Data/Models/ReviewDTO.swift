import Foundation

struct ReviewDTO: Codable {
    let restaurantName: String
    let restaurantAddress: String
    let lightRate: Float
    let waitRate: Float
    let soundRate: Float
    let userPhotos: [Data]
    let userTags: [String]
    let restaurantRate: Int
}
