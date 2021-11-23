protocol RemoteDatabaseServiceProtocol {
    func saveRestaurant(_ restaurant: Restaurant)
    func fetchRestaurant(for id: String)
}
