import SwiftUI

struct MainCard: View {
    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var image: String
    var address: String
    var price: Int
    @State private var maxRate = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Image(image)
                    .resizable()
                    .saturation(0)
                    .contrast(1.2)
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()

                VStack {
                    ReviewedTag()
                        .padding(10)
                }
                .frame(width: 320, height: 120, alignment: .bottomTrailing)

                VStack {
                    BookmarkButton()
                        .padding(10)
                }
                .frame(width: 320, height: 120, alignment: .topTrailing)
            }

            HStack {
                Text(restaurantName.uppercased())
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .padding(10)
                    .frame(height: 50)

                Spacer()
            }
            .border(Color.black, width: 0.3)

            HStack(spacing: 0) {
                Image(systemName: "location")
                    .padding(.leading, 10)
                    .font(.system(size: 12, weight: .light, design: .default))
                Text(address)
                    .font(.system(size: 11, weight: .light, design: .default))
                    .padding(5)
            }

            HStack(spacing: 0) {
                Image(systemName: "dollarsign.circle")
                    .padding(.leading, 10)
                    .padding(.trailing, 5)
                    .font(.system(size: 12, weight: .light, design: .default))

                ForEach(0..<price) { _ in
                    Text("$")
                        .font(.system(size: 11, weight: .light, design: .default))
                }

                Spacer()

                ForEach(0..<maxRate) { num in
                    Image(systemName: num < restaurantRate ? "star.fill" : "star")
                        .font(.system(size: 9, weight: .regular, design: .default))
                        .padding(1)
                }
                .font(.system(size: 12, weight: .light, design: .default))
            }
            .padding(.vertical, 5)
            .padding(.trailing, 10)
        }
        .frame(width: 320)
        .border(Color.black, width: 0.3)
    }
}
