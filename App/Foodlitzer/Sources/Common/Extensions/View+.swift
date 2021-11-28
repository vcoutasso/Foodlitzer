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

    func buttonDisableAnimation(state: Bool) -> some View {
        modifier(ButtonDisableAnimation(disabled: state))
    }

    func bottomLine() -> some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)
            .padding(.top, 34)
    }

    func underlineTextField(isEditing: Bool) -> some View {
        padding(.vertical, 20)
            .overlay(ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)

                Rectangle()
                    .frame(width: isEditing ? UIScreen.main.bounds.width - 50 : 0, height: isEditing ? 1.5 : 0.3)
                    .animation(.default, value: isEditing)
            }
            .padding(.top, 35))
            .foregroundColor(.black)
    }

    func largeTextDisplay() -> some View {
        modifier(LargeTextDisplay())
    }
}
