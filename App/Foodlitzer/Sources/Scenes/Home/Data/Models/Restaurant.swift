import FirebaseFirestoreSwift
import UIKit

struct Restaurant: Codable {
    @DocumentID var id: String?
    let name: String
    let rating: Float
    let totalRatings: Int
    let address: String
    let priceLevel: Int
    var imagesData: [Data]
}
