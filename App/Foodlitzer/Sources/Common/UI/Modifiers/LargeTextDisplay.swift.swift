import SwiftUI

struct LargeTextDisplay: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .lineSpacing(15)
            .font(.sfCompactText(.light, size: 14))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 40)
            .padding(.horizontal, 40)
    }
}
