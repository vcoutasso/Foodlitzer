import SwiftUI

struct SegmentedPickerBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 4)
            .foregroundColor(.black)
    }
}

extension View {
    func segmentedPickerBarStyle() -> some View {
        modifier(SegmentedPickerBar())
    }
}
