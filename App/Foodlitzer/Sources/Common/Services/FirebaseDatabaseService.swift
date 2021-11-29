import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseDatabaseService<T>: RemoteDatabaseServiceProtocol where T: Codable {
    typealias DataType = T

    // MARK: - Properties

    private let database = Firestore.firestore()

    // MARK: - Save data

    func setDocument(_ data: DataType, with id: String, to path: String) {
        let document = database.collection(path).document(id)

        do {
            _ = try document.setData(from: data)
        } catch {
            debugPrint("Error saving data to firestore: \(error.localizedDescription)")
        }
    }

    func setBatch(_ data: [DataType], with id: String, to path: String) {
        let batch = database.batch()
        let document = database.collection(path).document(id)

        do {
            try batch.setData(from: data, forDocument: document)
            batch.commit()
        } catch {
            debugPrint("Error saving batch data: \(error.localizedDescription)")
        }
    }

    func addDocument(_ data: DataType, to path: String) {
        let collection = database.collection(path)

        do {
            _ = try collection.addDocument(from: data)
        } catch {
            debugPrint("Error saving data to firestore: \(error.localizedDescription)")
        }
    }

    func addBatch(_ data: [DataType], to path: String) {
        let batch = database.batch()
        let document = database.collection(path).document()

        do {
            try batch.setData(from: data, forDocument: document)
            batch.commit()
        } catch {
            debugPrint("Error saving batch data: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch data

    func fetchCollection(from path: String) async -> [DataType] {
        var result = [DataType]()
        let collection = database.collection(path)

        do {
            let querySnapshot = try await collection.getDocuments()
            result = querySnapshot.documents.compactMap { try? $0.data(as: DataType.self) }
        } catch {
            debugPrint("Error fetching data from firestore: \(error.localizedDescription)")
        }

        return result
    }

    func fetchDocument(from path: String) async -> DataType? {
        var result: DataType?
        let document = database.document(path)

        do {
            let querySnapshot = try await document.getDocument()
            result = try? querySnapshot.data(as: DataType.self)
        } catch {
            debugPrint("Error fetching data from firestore: \(error.localizedDescription)")
        }

        return result
    }

    // MARK: - Query

    func queryCollection(from path: String, where field: String, matches query: String) async -> [DataType] {
        var result = [DataType]()
        let collection = database.collection(path)

        do {
            let querySnapshot = try await collection.whereField(field, isEqualTo: query).getDocuments()
            result = querySnapshot.documents.compactMap { try? $0.data(as: DataType.self) }
        } catch {
            debugPrint("Error querying data from firestore: \(error.localizedDescription)")
        }

        return result
    }

    // MARK: - Document count

    func documentCount(from path: String) async -> Int? {
        var result: Int?

        do {
            result = try await database.collection(path).getDocuments().count
        } catch {
            debugPrint("Error querying for document count: \(error.localizedDescription)")
        }

        return result
    }
}
