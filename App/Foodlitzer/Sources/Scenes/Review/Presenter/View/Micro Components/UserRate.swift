import SwiftUI

struct UserRate: View {
    @Binding var rating: Int
    var maxRating = 5

    var offImage = Image(systemName: "hand.thumbsup")
    var onImage = Image(systemName: "hand.thumbsup.fill")

    var body: some View {
        HStack(spacing: 15) {
            Spacer()
            ForEach(1..<maxRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(Color.black)
                    .onTapGesture {
                        self.rating = number
                    }
            }
            .font(.system(size: 24, weight: .light, design: .default))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 80, height: 30)
    }

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

#if DEBUG
    struct UserRate_Previews: PreviewProvider {
        static var previews: some View {
            UserRate(rating: .constant(4))
        }
    }
#endif
