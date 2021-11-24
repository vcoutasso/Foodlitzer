protocol RemoteDatabaseServiceProtocol {
    func saveRestaurant(_ restaurant: Restaurant)
    func fetchRestaurants() async -> [Restaurant]
}
