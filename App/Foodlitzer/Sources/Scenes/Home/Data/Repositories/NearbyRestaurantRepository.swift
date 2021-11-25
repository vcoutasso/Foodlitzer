import Foundation

protocol NearbyRestaurantRepositoryProtocol {
    typealias RestaurantTupleDTO = ([RestaurantInfoDTO], [[RestaurantImageDTO]], [[RestaurantVideoDTO]])

    func fetchRestaurants(latitude: String, longitude: String) async -> RestaurantTupleDTO
}

final class NearbyRestaurantRepository: NearbyRestaurantRepositoryProtocol {
    // MARK: - Dependencies

    private let databaseService: FirebaseDatabaseService<RestaurantInfoDTO>
    private let mediaService: PlaceMediaServiceProtocol
    private let placesService: NearbyPlacesServiceProtocol

    // MARK: - Properties

    private let invalidTypes: [String]

    // MARK: - Object lifecycle

    init(databaseService: FirebaseDatabaseService<RestaurantInfoDTO>,
         mediaService: PlaceMediaServiceProtocol,
         placesService: NearbyPlacesServiceProtocol,
         invalidTypes: [String]) {
        self.databaseService = databaseService
        self.mediaService = mediaService
        self.placesService = placesService
        self.invalidTypes = invalidTypes
    }

    // MARK: - Fetch restaraunts

    func fetchRestaurants(latitude: String, longitude: String) async -> RestaurantTupleDTO {
        let googlePlacesDTO = await placesService.fetchNearbyPlaces(latitude: latitude, longitude: longitude)
        let restaurantsDTO = parsePlaces(googlePlacesDTO)
        var imagesDTO = [[RestaurantImageDTO]](repeating: [], count: restaurantsDTO.count)
        // FIXME: Fetch video data
        var videosDTO = [[RestaurantVideoDTO]](repeating: [], count: restaurantsDTO.count)

        DispatchQueue.main.async { [weak self, restaurantsDTO] in
            self?.uploadToDatabase(restaurants: restaurantsDTO)
        }

        for idx in restaurantsDTO.indices {
            guard let id = restaurantsDTO[idx].id else { continue }

            imagesDTO[idx] = await mediaService.fetchImages(for: id)
        }

        return (restaurantsDTO, imagesDTO, videosDTO)
    }

    private func uploadToDatabase(restaurants: [RestaurantInfoDTO]) {
        restaurants.forEach {
            guard let id = $0.id else { return }

            databaseService.setDocument($0, with: id, to: "restaurants")
        }
    }

    // MARK: - Helper methods

    private func parsePlaces(_ places: [GooglePlaceDTO]) -> [RestaurantInfoDTO] {
        places.compactMap { dto in
            guard let id = dto.placeID,
                  let name = dto.name,
                  let rating = dto.rating,
                  let totalRatings = dto.totalRatings,
                  let address = dto.address,
                  let priceLevel = dto.priceLevel,
                  let types = dto.types,
                  isValid(types: types) else { return nil }

            return RestaurantInfoDTO(id: id,
                                     name: name,
                                     rating: rating,
                                     totalRatings: totalRatings,
                                     address: address,
                                     priceLevel: priceLevel)
        }
    }

    private func isValid(types: [String]) -> Bool {
        invalidTypes.map { types.contains($0) }.allSatisfy { $0 == false }
    }
}
