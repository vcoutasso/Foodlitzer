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
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .padding(10)
                    .frame(height: 50)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .padding(10)
            }
            .foregroundColor(.black)
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
        .border(Color.black, width: 0.3)
        .padding()
    }
}
