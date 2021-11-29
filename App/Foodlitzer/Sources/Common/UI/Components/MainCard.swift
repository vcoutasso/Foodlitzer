import SwiftUI

struct MainCard<Destination: View>: View {
    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var image: Image
    var address: String
    var price: Int
    @State private var maxRate = 5

    var destination: () -> Destination

    init(restaurantName: String, restaurantRate: Int, isReviewed: Bool, image: Image, address: String, price: Int,
         destination: @escaping () -> Destination) {
        self.restaurantName = restaurantName
        self.restaurantRate = restaurantRate
        self.isReviewed = isReviewed
        self.image = image
        self.address = address
        self.price = price
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    image
                        .resizable()
                        .imageFilter()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()

                    if isReviewed {
                        VStack {
                            ReviewedTag()
                                .padding(10)
                        }
                        .frame(width: 320, height: 120, alignment: .bottomTrailing)
                    }

                    VStack {
                        BookmarkButton()
                            .padding(10)
                    }
                    .frame(width: 320, height: 120, alignment: .topTrailing)
                }

                HStack {
                    Text(restaurantName.uppercased())
                        .font(.sfCompactText(.regular, size: 12))
                        .padding(10)
                        .frame(height: 50)

                    Spacer()
                }
                .border(Color.black, width: 0.3)

                HStack(spacing: 0) {
                    Image(systemName: Strings.Symbols.address)
                        .padding(.leading, 10)
                        .font(.system(size: 12, weight: .light, design: .default))
                    Text(address)
                        .font(.sfCompactText(.light, size: 11))
                        .padding(5)
                }

                HStack(spacing: 0) {
                    Image(systemName: Strings.Symbols.price)
                        .padding(.leading, 10)
                        .padding(.trailing, 5)
                        .font(.system(size: 12, weight: .light, design: .default))

                    ForEach(0..<price) { _ in
                        Text("$")
                            .font(.sfCompactText(.light, size: 11))
                    }

                    Spacer()

                    ForEach(0..<maxRate) { num in
                        Image(systemName: num < restaurantRate ? Strings.Symbols.starFill : Strings.Symbols.star)
                            .font(.system(size: 9, weight: .regular, design: .default))
                            .padding(1)
                    }
                    .font(.system(size: 12, weight: .light, design: .default))
                }
                .padding(.vertical, 5)
                .padding(.trailing, 10)
            }
            .frame(width: 320)
            .foregroundColor(.black)
            .border(Color.black, width: 0.3)
        }
    }
}
