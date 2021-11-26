import SwiftUI

struct Slider: View {
    @Binding var value: CGFloat
    var isEditing: Bool

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Capsule()
                .frame(height: 15)
                .foregroundColor(Color.black.opacity(0.3))

            Capsule()
                .fill(Color.black)
                .frame(width: value + 26, height: 15)

            if isEditing {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 26, height: 26)
                    .background(Circle().stroke(Color.white, lineWidth: 5))
                    .offset(x: value)
                    .gesture(DragGesture().onChanged { num in

                        // padding horizontal
                        // CircleHeigh = 26 + 5
                        // CircleRadius = 15.5

                        if num.location.x > 15.5, num.location.x <= UIScreen.main.bounds.width - 155.5 {
                            value = num.location.x - 10
                        }
                    })
            }
        }
    }
}
