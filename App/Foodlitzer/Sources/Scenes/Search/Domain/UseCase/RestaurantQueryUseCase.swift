import Foundation

protocol RestaurantQueryUseCaseProtocol {
    func execute(query: String, for field: String) async -> [RestaurantInfoDTO]
}

final class RestaurantQueryUseCase: RestaurantQueryUseCaseProtocol {
    // MARK: - Dependencies

    private let restaurantDatabaseService: FirebaseDatabaseService<RestaurantInfoDTO>

    // MARK: - Initialization

    init(restaurantDatabaseService: FirebaseDatabaseService<RestaurantInfoDTO>) {
        self.restaurantDatabaseService = restaurantDatabaseService
    }

    // MARK: - Fetch query

    func execute(query: String, for field: String) async -> [RestaurantInfoDTO] {
        let path = "restaurants"
        return await restaurantDatabaseService.queryCollection(from: path, where: field, matches: query)
    }
}
