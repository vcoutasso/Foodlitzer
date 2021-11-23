import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseDatabaseService: RemoteDatabaseServiceProtocol {
    // MARK: - Properties

    private let database = Firestore.firestore()
    private lazy var restaurantCollection = database.collection("restaurants")

    // MARK: - Save data

    func saveRestaurant(_ restaurant: Restaurant) {
        do {
            _ = try restaurantCollection.addDocument(from: restaurant)
        } catch {
            debugPrint("Error saving data to firestore: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch data

    func fetchRestaurants() async -> [Restaurant] {
        return await withCheckedContinuation { continuation in
            restaurantCollection.addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }

                if let error = error {
                    debugPrint("Error fetching data from firestore: \(error.localizedDescription)")
                }

                let restaurants = documents.compactMap { try? $0.data(as: Restaurant.self) }

                continuation.resume(returning: restaurants)
            }
        }
    }
}
