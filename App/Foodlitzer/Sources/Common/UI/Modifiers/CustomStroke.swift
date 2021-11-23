import SwiftUI

struct CustomStroke: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .border(Color.black, width: 0.3)
    }
}
