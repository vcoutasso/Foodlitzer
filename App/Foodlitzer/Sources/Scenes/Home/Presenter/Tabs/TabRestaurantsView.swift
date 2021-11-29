import SwiftUI

struct TabRestaurantsView: View {
    @MainActor var viewModel: TabRestaurantViewModel
    @State private(set) var restaurants: [Model] = []

    var body: some View {
        ScrollView {
            if restaurants.isEmpty {
                ProgressView()
                    .padding(.top, 200)
                    .onAppear {
                        viewModel.handleOnAppear()
                        Task {
                            // FIXME: Should try again when permission is granted
                            restaurants = await viewModel.fetchRestaurants()
                        }
                    }
            } else {
                Text(Localizable.Restaurants.Nearby.label)
                    .font(.lora(.regular, size: 24))
                    .padding(.top, 55)

                Text(Localizable.Restaurants.Nearby.text)
                    .font(.sfCompactText(.regular, size: 14))
                    .padding(.bottom, 30)

                ForEach(restaurants) { restaurant in
                    MainCard(restaurantName: restaurant.name,
                             restaurantRate: Int(restaurant.rating),
                             isReviewed: false,
                             image: restaurant.images.first ?? Image(Assets.Images.placeholderPizza),
                             address: restaurant.address,
                             price: restaurant.price,
                             destination: {
                                 InformationView(restaurantName: restaurant.name,
                                                 restaurantRate: Int(restaurant.rating),
                                                 isReviewed: false,
                                                 images: restaurant.images,
                                                 address: restaurant.address,
                                                 price: restaurant.price)
                             })
                             .padding(.bottom, 20)
                }
                .padding(.horizontal, 35)

                // TODO: Salvar restaurantes?

                Button {
                    // destination
                } label: {
                    Text(Localizable.Restaurants.ShowMore.text)
                        .font(.sfCompactText(.regular, size: 14))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                        .background(Color.black)
                }
                .padding(.bottom, 50)
            }
        }
    }

    struct Model: Identifiable {
        let id: String
        let name: String
        let address: String
        let images: [Image]
        let rating: Float
        let price: Int
    }
}
