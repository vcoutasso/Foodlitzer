import SwiftUI

struct VerticalCard: View {
    var restaurantName: String
    var image: Image

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .imageFilter()
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
                .font(.sfCompactText(.regular, size: 12))
                .padding(10)
                .multilineTextAlignment(.center)
                .frame(height: 80)
        }
        .border(Color.black, width: 0.3)
        .frame(width: 140)
    }
}
