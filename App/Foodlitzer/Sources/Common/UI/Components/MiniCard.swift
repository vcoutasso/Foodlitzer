import SwiftUI

struct MiniCard<Destination: View>: View {
    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var image: Image
    @State private var maxRate = 5
    var destination: () -> Destination

    init(restaurantName: String, restaurantRate: Int, isReviewed: Bool, image: Image,
         destination: @escaping () -> Destination) {
        self.restaurantName = restaurantName
        self.restaurantRate = restaurantRate
        self.isReviewed = isReviewed
        self.image = image
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            VStack(alignment: .leading, spacing: 0) {
                image
                    .resizable()
                    .scaledToFill()
                    .imageFilter()
                    .frame(height: 135)

                Text(restaurantName.uppercased())
                    .font(.sfCompactText(.regular, size: 12))
                    .padding(10)
                    .frame(height: 50)

                HStack(alignment: .center, spacing: 2) {
                    ForEach(0..<maxRate) { num in
                        Image(systemName: num < restaurantRate ? Strings.Symbols.starFill : Strings.Symbols.star)
                            .font(.system(size: 9, weight: .regular, design: .default))
                    }

                    Spacer()

                    if isReviewed {
                        ReviewedTag()
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .border(Color.black, width: 0.3)
            }
            .border(Color.black, width: 0.3)
            .foregroundColor(.black)
            .frame(width: 230)
        }
    }
}
