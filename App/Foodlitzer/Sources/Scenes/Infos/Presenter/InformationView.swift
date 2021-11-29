import SwiftUI

struct InformationView: View {
    // MARK: Atributos

    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var images: [Image]
    var address: String
    var price: Int

    var body: some View {
        ZStack {
            PlayerView()
                .ignoresSafeArea()
            TabView {
                InfoPageOneView(restaurantName: restaurantName,
                                restaurantRate: restaurantRate,
                                isReviewed: isReviewed,
                                image: images.first ?? Image(Assets.Images.placeholderPizza),
                                address: address,
                                price: price)
                InfoPageTwoView()
                InfoPageThreeView(imagens: images)
                    .ignoresSafeArea()
                // InfoPageFourView()
            }
            TopInfoView(restaurantName: restaurantName)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .onAppear {
            UINavigationBar.appearance().tintColor = .white
        }
        .onDisappear {
            UINavigationBar.appearance().tintColor = .black
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // action here

                } label: {
                    Image("info.circle")
                        .font(.system(size: 24))
                }
            }
        }
    }
}
