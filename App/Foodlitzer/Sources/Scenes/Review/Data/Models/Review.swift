import UIKit

struct Review {
    let restaurantID: String
    let ambientLighting: CGFloat
    let waitingTime: CGFloat
    let ambientNoise: CGFloat
    let userVideos: [URL]
    let userPhotos: [UIImage]
    let userTags: [String]
    let userRating: Int
}
