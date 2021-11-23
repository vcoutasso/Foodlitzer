import SwiftUI
import UIKit

extension Data {
    func asUIImage() -> UIImage? {
        UIImage(data: self)
    }

    func asImage() -> Image? {
        guard let uiImage = asUIImage() else { return nil }

        return Image(uiImage: uiImage)
    }
}
