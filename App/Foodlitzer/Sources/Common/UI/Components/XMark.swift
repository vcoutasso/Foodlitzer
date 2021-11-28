import SwiftUI

struct XMark: View {
    @Binding var fade: Bool
    @Binding var set: Bool

    var body: some View {
        Image(systemName: "xmark.circle")
            .font(.system(size: 18))
            .foregroundColor(fade ? .black : .clear)
            .frame(width: UIScreen.main.bounds.width - 50, height: 0.3, alignment: .trailing)
            .animation(.default, value: fade)
            .onAppear {
                withAnimation(.easeInOut(duration: 3)) {
                    fade = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        fade = false
                        set = false
                    }
                }
            }
    }
}
