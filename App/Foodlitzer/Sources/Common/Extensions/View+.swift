import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func segmentedPickerBarStyle() -> some View {
        modifier(SegmentedPickerBar())
    }

    func customStroke() -> some View {
        modifier(CustomStroke())
    }

    func imageFilter() -> some View {
        modifier(ImageFilter())
    }
}
