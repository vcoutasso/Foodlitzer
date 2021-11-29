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
                        DispatchQueue.main.async {
                            viewModel.handleButtonTapped { restaurants in
                                self.restaurants = restaurants
                            }
                        }
                        viewModel.handleOnAppear()
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
                             price: restaurant.price)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 35)

                // TODO: Abrir página do restaurante on tap
                // TODO: Salvar restaurantes?

                NavigationLink {
                    // destination
                } label: {
                    Text(Localizable.Restaurants.ShowMore.text)
                        .font(.sfCompactText(.regular, size: 14))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                        .background(Color.black)
                }
                .padding(.bottom, 50)

                Text(Localizable.Restaurants.Experienced.label)
                    .font(.lora(.regular, size: 24))

                Text(Localizable.Restaurants.Experienced.text)
                    .font(.sfCompactText(.regular, size: 14))
                    .padding(.bottom, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30, height: 30)

                        ForEach(restaurants) { restaurant in
                            MiniCard(restaurantName: restaurant.name, restaurantRate: 5, isReviewed: true,
                                     image: Image(Assets.Images.placeholderPizza))
                                .padding(.trailing, 30)
                        }
                    } // TODO: Implementar histórico de visita do usuário
                }
                .padding(.bottom, 30)

                NavigationLink {
                    // destination
                } label: {
                    Text(Localizable.Restaurants.ShowMore.text)
                        .font(.sfCompactText(.light, size: 14))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                        .background(Color.black)
                }
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
