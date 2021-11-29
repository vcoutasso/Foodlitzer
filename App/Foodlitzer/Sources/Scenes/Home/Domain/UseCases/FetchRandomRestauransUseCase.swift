import UIKit

protocol FetchRandomRestaurantsUseCaseProtocol {
    func execute(for amount: Int) async -> [Restaurant]
}

final class FetchRandomRestaurantsUseCase: FetchRandomRestaurantsUseCaseProtocol {
    // MARK: - Dependencies

    private let fetchRestaurantsService: FetchRestaurantsServiceProtocol
    private let fetchRestaurantMediaService: RestaurantMediaServiceProtocol

    // MARK: - Initialization

    init(fetchRestaurantsService: FetchRestaurantsServiceProtocol,
         fetchRestaurantMediaService: RestaurantMediaServiceProtocol) {
        self.fetchRestaurantsService = fetchRestaurantsService
        self.fetchRestaurantMediaService = fetchRestaurantMediaService
    }

    // MARK: - Execute

    func execute(for amount: Int) async -> [Restaurant] {
        let dtos = await fetchRestaurantsService.fetchRestaurants()
        let randomDTOs = dtos.shuffled().prefix(amount)
        var restaurants = [Restaurant]()

        for dto in randomDTOs {
            guard let id = dto.id else { continue }

            let images = await fetchRestaurantMediaService.fetchImages(for: id)
                .compactMap { UIImage(data: $0.imageData) }

            restaurants.append(Restaurant(id: id,
                                          name: dto.name,
                                          rating: dto.rating,
                                          totalRatings: dto.totalRatings,
                                          address: dto.address,
                                          priceLevel: dto.priceLevel,
                                          images: images))
        }

        return restaurants
    }
}
