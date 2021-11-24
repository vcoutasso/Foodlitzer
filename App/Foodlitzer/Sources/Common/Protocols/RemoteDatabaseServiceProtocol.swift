protocol RemoteDatabaseServiceProtocol {
    associatedtype DataType: Codable

    func saveData(_ data: DataType)
    func fetchData() async -> [DataType]
}
