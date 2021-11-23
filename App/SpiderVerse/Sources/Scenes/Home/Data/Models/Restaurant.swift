import FirebaseFirestoreSwift
import UIKit

struct Restaurant: Codable {
    @DocumentID var id: String?
    let name: String
    let rating: Float
    let totalRatings: Int
    let address: String
    var imagesData: [Data]
}
