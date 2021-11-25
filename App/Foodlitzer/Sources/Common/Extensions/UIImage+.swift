import SwiftUI
import UIKit

extension UIImage {
    enum CompressionQuality: CGFloat {
        case lowest = 0.1
        case low = 0.2
        case medium = 0.5
        case high = 0.75
        case lossless = 1.0
    }

    func compressedJPEG(quality: CompressionQuality = .low) -> Data? {
        jpegData(compressionQuality: quality.rawValue)
    }

    func asImage() -> Image? {
        Image(uiImage: self)
    }
}
