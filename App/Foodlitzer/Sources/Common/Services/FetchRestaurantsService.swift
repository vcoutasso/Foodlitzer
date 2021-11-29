import Foundation

protocol FetchRestaurantsServiceProtocol {
    func fetchRestaurants() async -> [RestaurantInfoDTO]
}

final class FetchRestaurantsService: FetchRestaurantsServiceProtocol {
    // MARK: - Dependencies

    private let databaseRestaurantService: FirebaseDatabaseService<RestaurantInfoDTO>

    // MARK: - Constants

    private let collectionPath = "restaurants"

    // MARK: - Initialization

    init(databaseRestaurantService: FirebaseDatabaseService<RestaurantInfoDTO>) {
        self.databaseRestaurantService = databaseRestaurantService
    }

    func fetchRestaurants() async -> [RestaurantInfoDTO] {
        await databaseRestaurantService.fetchCollection(from: collectionPath)
    }
}
