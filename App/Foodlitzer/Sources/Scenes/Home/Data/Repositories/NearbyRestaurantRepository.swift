import Foundation

protocol NearbyRestaurantRepositoryProtocol {
    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant]
}

final class NearbyRestaurantRepository: NearbyRestaurantRepositoryProtocol {
    // MARK: - Dependencies

    private let databaseService: FirebaseDatabaseService<Restaurant>
    private let photosService: PlacePhotosServiceProtocol
    private let placesService: NearbyPlacesServiceProtocol

    // MARK: - Properties

    private let invalidTypes: [String]

    // MARK: - Object lifecycle

    init(databaseService: FirebaseDatabaseService<Restaurant>,
         photosService: PlacePhotosServiceProtocol,
         remoteService: NearbyPlacesServiceProtocol,
         invalidTypes: [String]) {
        self.databaseService = databaseService
        self.photosService = photosService
        self.placesService = remoteService
        self.invalidTypes = invalidTypes
    }

    // MARK: - Fetch restaraunts

    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant] {
        let placesDTO = await placesService.fetchNearbyPlaces(latitude: latitude, longitude: longitude)
        var restaurants = parsePlaces(placesDTO)

        for index in restaurants.indices {
            restaurants[index].imagesData = await withCheckedContinuation { continuation in
                guard let id = restaurants[index].id else { return }

                photosService.fetchPlaceImages(for: id) { images in
                    let compressedImages = images.prefix(5).compactMap { $0.jpegData(compressionQuality: 0.20) }
                    continuation.resume(returning: compressedImages)
                }
            }
        }

        let restaurantsWithImages = restaurants.filter { !$0.imagesData.isEmpty }

        DispatchQueue.main.async { [weak self] in
            self?.uploadToDatabase(restaurants: restaurantsWithImages)
        }

        return restaurantsWithImages
    }

    private func uploadToDatabase(restaurants: [Restaurant]) {
        restaurants.forEach { databaseService.saveData($0) }
    }

    // MARK: - Helper methods

    private func parsePlaces(_ places: [GooglePlaceDTO]) -> [Restaurant] {
        places.compactMap { dto in
            guard let id = dto.placeID,
                  let name = dto.name,
                  let rating = dto.rating,
                  let totalRatings = dto.totalRatings,
                  let address = dto.address,
                  let priceLevel = dto.priceLevel,
                  let types = dto.types,
                  isValid(types: types) else { return nil }

            return Restaurant(id: id,
                              name: name,
                              rating: rating,
                              totalRatings: totalRatings,
                              address: address,
                              priceLevel: priceLevel,
                              imagesData: [])
        }
    }

    private func isValid(types: [String]) -> Bool {
        invalidTypes.map { types.contains($0) }.allSatisfy { $0 == false }
    }
}
