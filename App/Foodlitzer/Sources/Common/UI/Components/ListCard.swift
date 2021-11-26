import SwiftUI

struct ListCard: View {
    var restaurantName: String
    var restaurantRate: Int
    var address: String
    var price: Int
    @State private var maxRate = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(restaurantName.uppercased())
                    .font(.compact(.regular, size: 12))
                    .padding(10)
                    .frame(height: 50)

                Spacer()

                Image(systemName: Strings.Symbols.navigation)
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .padding(10)
            }
            .foregroundColor(.black)
            .border(Color.black, width: 0.3)

            HStack(spacing: 0) {
                Image(systemName: Strings.Symbols.address)
                    .padding(.leading, 10)
                    .font(.system(size: 12, weight: .light, design: .default))
                Text(address)
                    .font(.compact(.light, size: 11))
                    .padding(5)
            }

            HStack(spacing: 0) {
                Image(systemName: Strings.Symbols.price)
                    .padding(.leading, 10)
                    .padding(.trailing, 5)
                    .font(.system(size: 12, weight: .light, design: .default))

                ForEach(0..<price) { _ in
                    Text("$")
                        .font(.compact(.light, size: 11))
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
        .background(Color.white)
        .border(Color.black, width: 0.3)
        .padding(.horizontal, 35)
        .padding(.bottom, 20)
    }
}
