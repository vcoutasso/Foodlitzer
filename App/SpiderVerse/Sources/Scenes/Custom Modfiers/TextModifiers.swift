import SwiftUI

struct CompactMedium14: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SF Compact Medium", size: 14)) // Change font
    }
}

extension View {
    func compactMedium14() -> some View {
        modifier(CompactMedium14())
    }
}
