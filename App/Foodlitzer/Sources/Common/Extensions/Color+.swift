import SwiftUI

extension Color {
    init(_ asset: ColorAsset) {
        self.init(asset.name)
    }
}
