import SwiftUI

struct ReviewData {
    var restaurantName: String
    var restaurantAddress: String
    var lightRate: CGFloat = 0
    var waitRate: CGFloat = 0
    var soundRate: CGFloat
    var userPhotos: [Data] // Verificar qual tipo
    var userTags: [String]
    var restaurantRate: Int
}
