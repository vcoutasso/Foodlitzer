import UIKit

protocol FetchNearbyRestaurantsUseCaseProtocol {
    func execute(latitude: String, longitude: String) async -> [Restaurant]
}

final class FetchNearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol {
    // MARK: - Dependencies

    private let repository: NearbyRestaurantRepositoryProtocol

    // MARK: - Object lifecycle

    init(repository: NearbyRestaurantRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Protocol methods

    func execute(latitude: String, longitude: String) async -> [Restaurant] {
        let (infosDTO, imagesDTO) = await repository.fetchRestaurants(latitude: latitude,
                                                                      longitude: longitude)

        let restaurantImages = imagesDTO.map { $0.compactMap { UIImage(data: $0.imageData) } }

        var restaurants = [Restaurant]()

        for (restaurant, images) in zip(infosDTO, restaurantImages) {
            guard let id = restaurant.id else { continue }

            restaurants.append(Restaurant(id: id,
                                          name: restaurant.name,
                                          rating: restaurant.rating,
                                          totalRatings: restaurant.totalRatings,
                                          address: restaurant.address,
                                          priceLevel: restaurant.priceLevel,
                                          images: images))
        }

        return topRated(restaurants: restaurants)
    }

    // MARK: - Helper methods

    // TODO: The filtering should probably be configurable through a dependency
    private func topRated(restaurants: [Restaurant], count: Int = 5) -> [Restaurant] {
        Array(restaurants.sorted(by: { $0.rating * Float($0.totalRatings) > $1.rating * Float($1.totalRatings) })
            .prefix(count))
    }
}
