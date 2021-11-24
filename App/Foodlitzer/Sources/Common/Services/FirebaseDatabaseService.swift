import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseDatabaseService<DataType>: RemoteDatabaseServiceProtocol where DataType: Codable {
    // MARK: - Properties

    private let database = Firestore.firestore()
    private let collection: CollectionReference

    // MARK: - Object lifecycle

    init(collectionPath: String) {
        self.collection = database.collection(collectionPath)
    }

    // MARK: - Save data

    func saveData(_ data: DataType) {
        do {
            _ = try collection.addDocument(from: data)
        } catch {
            debugPrint("Error saving data to firestore: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch data

    func fetchData() async -> [DataType] {
        return await withCheckedContinuation { continuation in
            collection.addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }

                if let error = error {
                    debugPrint("Error fetching data from firestore: \(error.localizedDescription)")
                }

                let result = documents.compactMap { try? $0.data(as: DataType.self) }

                continuation.resume(returning: result)
            }
        }
    }
}
