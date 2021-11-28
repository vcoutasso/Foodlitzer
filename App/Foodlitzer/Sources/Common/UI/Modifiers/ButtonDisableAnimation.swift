import SwiftUI

struct ButtonDisableAnimation: ViewModifier {
    var disabled: Bool

    func body(content: Content) -> some View {
        content
            .disabled(disabled)
            .border(Color.black.opacity(0.3), width: disabled ? 0.3 : 0)
            .padding(.vertical, 16)
            .padding(.bottom, 30)
            .animation(.default, value: disabled)
    }
}
