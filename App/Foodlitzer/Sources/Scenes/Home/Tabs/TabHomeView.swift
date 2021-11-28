import SwiftUI

// MARK: - Inner types

struct TabHomeView: View {
    // MARK: - Properties

    @MainActor var viewModel: TabHomeViewModel
    @State private(set) var restaurants: [Restaurants] = []
    var body: some View {
        VStack {
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
                    description

                    Spacer()
                    bestReviewed

                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(restaurants) { restaurant in
                            MainCard(restaurantName: restaurant.name,
                                     restaurantRate: Int(restaurant.rating),
                                     isReviewed: false,
                                     image: restaurant.images.first ?? Image(Assets.Images.placeholderPizza),
                                     address: restaurant.address,
                                     price: restaurant.price)
                                .padding(.bottom, 20)
                        }
                    }

                    Spacer()
                    placesToDiscover
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
                }
            }
        }
    }

    private var helloName: some View {
        Text("Hello")
            .font(.custom("Lora-Regular", size: 24))
            .padding()
    }

    private var description: some View {
        VStack(alignment: .center) {
            VStack {
                Text(Localizable.Home.NewReviewMessage.text)
                    .font(.sfCompactText(.light, size: 14))
                    .lineSpacing(10)
                    .frame(width: 291, height: 98, alignment: .center)
                    .multilineTextAlignment(.center)
            }.background(Rectangle()
                .strokeBorder(lineWidth: 0.5)
                .frame(width: 330, height: 149))
            HStack {
                Image(systemName: "newspaper")
                NavigationLink {
                    NewReviewView(viewModel: NewReviewViewModelFactory.make())
                } label: {
                    Text(Localizable.Home.NewReviewButton.text)
                        .font(.sfCompactText(.regular, size: 12))
                        .foregroundColor(Color.white)
                        .background(Rectangle()
                            .frame(width: 195, height: 31, alignment: .center)
                            .background(Color.black))
                }
                .tint(.black)
            }.zIndex(10)
                .offset(x: -18, y: 5)
        }.padding(.top, 50)
    }

    private var bestReviewed: some View {
        VStack {
            Text(Localizable.Home.BestReview.label)
                .font(.custom("Lora-Regular", size: 24))
                .padding(.top, 30)
            Text(Localizable.Home.BestReview.text)
                .font(.sfCompactText(.light, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("textGray"))
                .frame(width: 313, height: 40, alignment: .center)
        }
    }

    private var placesToDiscover: some View {
        VStack {
            Text(Localizable.Home.PlaceDiscover.label)
                .font(.custom("Lora-Regular", size: 24))
            Text(Localizable.Home.PlaceDiscover.text)

                .font(.sfCompactText(.light, size: 14))
                .foregroundColor(Color("textGray"))
                .padding()
        }
    }

    struct Restaurants: Identifiable {
        let id: String
        let name: String
        let address: String
        let images: [Image]
        let rating: Float
        let price: Int
    }
}
