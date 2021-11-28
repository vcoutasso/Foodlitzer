import Foundation

protocol RestaurantQueryUseCaseProtocol {
    func execute(query: String, for field: String) async -> [RestaurantInfoDTO]
}

final class RestaurantQueryUseCase: RestaurantQueryUseCaseProtocol {
    // MARK: - Dependencies

    private let restaurantDatabaseService: FirebaseDatabaseService<RestaurantInfoDTO>

    // MARK: - Constants

    private let queryPath = "restaurants"

    // MARK: - Initialization

    init(restaurantDatabaseService: FirebaseDatabaseService<RestaurantInfoDTO>) {
        self.restaurantDatabaseService = restaurantDatabaseService
    }

    // MARK: - Fetch query

    func execute(query: String, for field: String) async -> [RestaurantInfoDTO] {
        await restaurantDatabaseService.queryCollection(from: queryPath, where: field, matches: query)
    }
}
