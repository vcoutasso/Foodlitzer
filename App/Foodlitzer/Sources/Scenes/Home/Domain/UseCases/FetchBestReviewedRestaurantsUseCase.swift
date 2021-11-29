import UIKit

protocol FetchBestReviewedRestaurantsUseCaseProtocol {
    func execute(for amount: Int) async -> [Restaurant]
}

final class FetchBestReviewedRestaurantsUseCase: FetchBestReviewedRestaurantsUseCaseProtocol {
    // MARK: - Dependencies

    private let fetchRestaurantsService: FetchRestaurantsServiceProtocol
    private let fetchReviewsService: FetchReviewsServiceProtocol
    private let fetchRestaurantMediaService: RestaurantMediaServiceProtocol

    // MARK: - Initialization

    init(fetchRestaurantsService: FetchRestaurantsServiceProtocol,
         fetchReviewsService: FetchReviewsServiceProtocol,
         fetchRestaurantMediaService: RestaurantMediaServiceProtocol) {
        self.fetchRestaurantsService = fetchRestaurantsService
        self.fetchReviewsService = fetchReviewsService
        self.fetchRestaurantMediaService = fetchRestaurantMediaService
    }

    // FIXME: This is absolutely hideous, horribly unoptimized, and perhaps worst of all: exageratelly expensive. I'm terribly sorry
    func execute(for amount: Int) async -> [Restaurant] {
        let restaurants = await fetchRestaurantsService.fetchRestaurants()
        var reviewCount = [Int]()

        for restaurant in restaurants {
            if let id = restaurant.id,
               let count = await fetchReviewsService.reviewCount(for: id) {
                reviewCount.append(count)
            }
        }

        let sortedIndices = reviewCount.enumerated()
            .sorted(by: { $0.element > $1.element }).map { $0.offset }
            .prefix(amount)
        var sortedRestaurants = [Restaurant]()

        for index in sortedIndices {
            guard let id = restaurants[index].id else { continue }

            let images = await fetchRestaurantMediaService.fetchImages(for: id)
                .compactMap { UIImage(data: $0.imageData) }
            sortedRestaurants.append(Restaurant(id: id,
                                                name: restaurants[index].name,
                                                rating: restaurants[index].rating,
                                                totalRatings: restaurants[index].totalRatings,
                                                address: restaurants[index].address,
                                                priceLevel: restaurants[index].priceLevel,
                                                images: images))
        }

        return sortedRestaurants
    }
}
