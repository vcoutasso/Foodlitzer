import Combine

protocol TabHomeViewModelProtocol: ObservableObject {
    func fetchBestReviewedRestaurants() async -> [TabHomeView.Restaurants]
    func fetchRandomRestaurants() async -> [TabHomeView.Restaurants]
}

final class TabHomeViewModel: TabHomeViewModelProtocol {
    // MARK: - Private properties

    private let bestReviewedRestaurantsUseCase: FetchBestReviewedRestaurantsUseCaseProtocol
    private let randomRestaurantsUseCase: FetchRandomRestaurantsUseCaseProtocol

    // MARK: Object lifecycle

    init(bestReviewedRestaurantsUseCase: FetchBestReviewedRestaurantsUseCaseProtocol,
         randomRestaurantsUseCase: FetchRandomRestaurantsUseCaseProtocol) {
        self.bestReviewedRestaurantsUseCase = bestReviewedRestaurantsUseCase
        self.randomRestaurantsUseCase = randomRestaurantsUseCase
    }

    // MARK: - Fetch best reviewed

    func fetchBestReviewedRestaurants() async -> [TabHomeView.Restaurants] {
        await bestReviewedRestaurantsUseCase.execute(for: 10).map {
            TabHomeView.Restaurants(id: $0.id,
                                    name: $0.name,
                                    address: $0.address,
                                    images: $0.images.compactMap { $0.asImage() },
                                    rating: $0.rating,
                                    price: $0.priceLevel)
        }
    }

    func fetchRandomRestaurants() async -> [TabHomeView.Restaurants] {
        await randomRestaurantsUseCase.execute(for: 10).map {
            TabHomeView.Restaurants(id: $0.id,
                                    name: $0.name,
                                    address: $0.address,
                                    images: $0.images.compactMap { $0.asImage() },
                                    rating: $0.rating,
                                    price: $0.priceLevel)
        }
    }
}

enum TabHomeViewModelFactory {
    static func make() -> TabHomeViewModel {
        let restaurantInfoService = FirebaseDatabaseService<RestaurantInfoDTO>()
        let restaurantReviewService = FirebaseDatabaseService<RestaurantReviewDTO>()
        let restaurantImageService = FirebaseDatabaseService<RestaurantImageDTO>()
        let restaurantVideoService = FirebaseDatabaseService<RestaurantVideoDTO>()
        let mediaService = RestaurantMediaService(databaseImageService: restaurantImageService,
                                                  databaseVideoService: restaurantVideoService)
        let fetchRestaurantsService = FetchRestaurantsService(databaseRestaurantService: restaurantInfoService)
        let fetchReviewsService = FetchReviewsService(databaseReviewsService: restaurantReviewService)
        let bestReviewedRestaurantsService =
            FetchBestReviewedRestaurantsUseCase(fetchRestaurantsService: fetchRestaurantsService,
                                                fetchReviewsService: fetchReviewsService,
                                                fetchRestaurantMediaService: mediaService)
        let randomRestaurantsService = FetchRandomRestaurantsUseCase(fetchRestaurantsService: fetchRestaurantsService,
                                                                     fetchRestaurantMediaService: mediaService)

        return TabHomeViewModel(bestReviewedRestaurantsUseCase: bestReviewedRestaurantsService,
                                randomRestaurantsUseCase: randomRestaurantsService)
    }
}
