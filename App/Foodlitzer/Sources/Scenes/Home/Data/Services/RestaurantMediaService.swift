import GooglePlaces
import UIKit

protocol RestaurantMediaServiceProtocol {
    func fetchImages(for id: String) async -> [RestaurantImageDTO]
    func fetchVideos(for id: String) async -> [RestaurantVideoDTO]
}

final class RestaurantMediaService: RestaurantMediaServiceProtocol {
    // MARK: - Properties

    private let placesClient = GMSPlacesClient.shared()

    // MARK: - Dependencies

    private let databaseImageService: FirebaseDatabaseService<RestaurantImageDTO>
    private let databaseVideoService: FirebaseDatabaseService<RestaurantVideoDTO>

    // MARK: - Initialization

    init(databaseImageService: FirebaseDatabaseService<RestaurantImageDTO>,
         databaseVideoService: FirebaseDatabaseService<RestaurantVideoDTO>) {
        self.databaseImageService = databaseImageService
        self.databaseVideoService = databaseVideoService
    }

    // MARK: - Fetch images

    func fetchImages(for id: String) async -> [RestaurantImageDTO] {
        var imageDTOs = await fetchFromDatabase(for: id)

        if imageDTOs.isEmpty {
            imageDTOs = await withCheckedContinuation { continuation in
                lookUpPhotos(for: id) { [weak self] metadataList, error in
                    guard let self = self else { return }

                    var placeImages = [UIImage?]()

                    if let error = error {
                        debugPrint("Error fetching photos metadata for place id \(id): \(error.localizedDescription)")
                    } else if let metadataList = metadataList {
                        for metadata in metadataList.results {
                            self.loadPlacePhoto(for: metadata) { placeImages.append($0) }
                        }
                    }

                    let compressedData = placeImages.compactMap { $0 }.compactMap { $0.compressedJPEG() }

                    let dtos = compressedData.map { RestaurantImageDTO(imageData: $0) }

                    self.uploadToDatabase(imageDTOs: dtos, for: id)

                    continuation.resume(returning: dtos)
                }
            }
        }

        return imageDTOs
    }

    private func fetchFromDatabase(for id: String) async -> [RestaurantImageDTO] {
        let data = await databaseImageService.fetchCollection(from: "restaurants/\(id)/images")

        return data
    }

    private func lookUpPhotos(for id: String, completion: @escaping (GMSPlacePhotoMetadataList?, Error?) -> Void) {
        placesClient.lookUpPhotos(forPlaceID: id, callback: completion)
    }

    private func loadPlacePhoto(for metadata: GMSPlacePhotoMetadata, completion: @escaping (UIImage?) -> Void) {
        placesClient.loadPlacePhoto(metadata) { photo, error in
            if let error = error {
                debugPrint("Error loading photo metadata: \(error.localizedDescription)")
            }

            completion(photo)
        }
    }

    private func uploadToDatabase(imageDTOs: [RestaurantImageDTO], for id: String) {
        let path = "restaurants/\(id)/images"

        let group = DispatchGroup()

        imageDTOs.forEach {
            group.enter()
            self.databaseImageService.addDocument($0, to: path)
            group.leave()
        }
    }

    // MARK: - Fetch videos

    func fetchVideos(for id: String) async -> [RestaurantVideoDTO] {
        []
    }
}
