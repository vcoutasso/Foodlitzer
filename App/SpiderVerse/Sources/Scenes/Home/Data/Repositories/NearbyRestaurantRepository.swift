import Foundation

protocol NearbyRestaurantRepositoryProtocol {
    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant]
}

final class NearbyRestaurantRepository: NearbyRestaurantRepositoryProtocol {
    // MARK: - Dependencies

    private let photosService: PlacePhotosServiceProtocol
    private let placesService: NearbyPlacesServiceProtocol

    // MARK: - Properties

    private let invalidTypes: [String]

    // MARK: - Object lifecycle

    init(photosService: PlacePhotosServiceProtocol,
         remoteService: NearbyPlacesServiceProtocol,
         invalidTypes: [String]) {
        self.photosService = photosService
        self.placesService = remoteService
        self.invalidTypes = invalidTypes
    }

    // MARK: - Fetch restaraunts

    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant] {
        let placesDTO = await placesService.fetchNearbyPlaces(latitude: latitude, longitude: longitude)
        var restaurants = parsePlaces(placesDTO)

        for index in restaurants.indices {
            restaurants[index].images = await withCheckedContinuation { continuation in
                photosService.fetchPlaceImages(for: restaurants[index].id) { images in
                    continuation.resume(returning: images)
                }
            }
        }

        return restaurants.filter { !$0.images.isEmpty }
    }

    // MARK: - Helper methods

    private func parsePlaces(_ places: [GooglePlaceDTO]) -> [Restaurant] {
        places.compactMap { dto in
            guard let id = dto.placeID,
                  let name = dto.name,
                  let rating = dto.rating,
                  let totalRatings = dto.totalRatings,
                  let address = dto.address,
                  let types = dto.types,
                  isValid(types: types) else { return nil }

            return Restaurant(id: id, name: name, rating: rating, totalRatings: totalRatings, address: address,
                              images: [])
        }
    }

    private func isValid(types: [String]) -> Bool {
        invalidTypes.map { types.contains($0) }.allSatisfy { $0 == false }
    }
}
