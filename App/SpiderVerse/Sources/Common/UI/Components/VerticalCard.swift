import SwiftUI

struct VerticalCard: View {
    var restaurantName: String
    var image: String

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .saturation(0)
                    .contrast(1.2)
                    .frame(width: 140, height: 170)
                    .border(Color.black, width: 0.3)
                    .clipped()

                VStack {
                    BookmarkButton()
                        .padding(10)
                }
                .frame(width: 140, height: 170, alignment: .topTrailing)
            }

            Text(restaurantName.uppercased())
                .font(.system(size: 12, weight: .regular, design: .default))
                .padding(10)
                .multilineTextAlignment(.center)
                .frame(height: 80)
        }
        .border(Color.black, width: 0.3)
        .frame(width: 140)
    }
}
