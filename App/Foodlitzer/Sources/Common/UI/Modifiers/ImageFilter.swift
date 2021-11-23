import SwiftUI

struct ImageFilter: ViewModifier {
    func body(content: Content) -> some View {
        content
            .saturation(0)
            .contrast(1.2)
    }
}
