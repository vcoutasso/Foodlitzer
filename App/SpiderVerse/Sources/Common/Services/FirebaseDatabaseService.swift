import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseDatabaseService: RemoteDatabaseServiceProtocol {
    // MARK: - Properties

    private let database = Firestore.firestore()

    // MARK: - Save data

    func saveRestaurant(_ restaurant: Restaurant) {
        do {
            _ = try database.collection("restaurants").addDocument(from: restaurant)
        } catch {
            debugPrint("Error saving restaurant data to firestore: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch data

    func fetchRestaurant(for id: String) {
        fatalError("Not implemented")
    }
}
