import SwiftUI

struct SegmentedPickerBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 4)
            .foregroundColor(.black)
    }
}

struct CustomStroke: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .border(Color.black, width: 0.3)
    }
}

extension View {
    func segmentedPickerBarStyle() -> some View {
        modifier(SegmentedPickerBar())
    }

    func customStroke() -> some View {
        modifier(CustomStroke())
    }
}
