import FirebaseFirestore

final class FirebaseDatabaseService: RemoteDatabaseServiceProtocol {
    // MARK: - Properties

    private let database = Firestore.firestore()

    // MARK: - Save data

    func save(restaurant: Restaurant) {
        guard let id = restaurant.id else { return }

        do {
            try database.collection("restaurants")
                .document(id)
                .setData(from: restaurant)
        } catch {
            debugPrint("Error saving restaurant data to firestore: \(error.localizedDescription)")
        }
    }
}
