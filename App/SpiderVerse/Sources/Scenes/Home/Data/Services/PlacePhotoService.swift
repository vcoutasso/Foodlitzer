import GooglePlaces
import UIKit

protocol PlacePhotosServiceProtocol {
    func fetchPlaceImages(for id: String, completion: @escaping ([UIImage]) -> Void)
}

final class PlacePhotosService: PlacePhotosServiceProtocol {
    // MARK: - Properties

    private let placesClient = GMSPlacesClient.shared()

    // MARK: - Fetch images

    func fetchPlaceImages(for id: String, completion: @escaping ([UIImage]) -> Void) {
        placesClient.lookUpPhotos(forPlaceID: id) { [weak self] metadataList, error in
            guard let self = self else { return }

            var images = [UIImage?]()

            if let error = error {
                debugPrint("Error fetching photos metadata for place id \(id): \(error.localizedDescription)")
            } else if let metadataList = metadataList {
                for metadata in metadataList.results {
                    self.loadPlacePhoto(for: metadata) { images.append($0) }
                }
            }

            completion(images.compactMap { $0 })
        }
    }

    private func loadPlacePhoto(for metadata: GMSPlacePhotoMetadata, completion: @escaping (UIImage?) -> Void) {
        placesClient.loadPlacePhoto(metadata) { photo, error in
            if let error = error {
                debugPrint("Error loading photo metadata: \(error.localizedDescription)")
            }

            completion(photo)
        }
    }
}
