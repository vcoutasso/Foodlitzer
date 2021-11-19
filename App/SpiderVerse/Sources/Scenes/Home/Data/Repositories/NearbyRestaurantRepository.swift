import Foundation

protocol NearbyRestaurantRepositoryProtocol {
    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant]
}

final class NearbyRestaurantRepository: NearbyRestaurantRepositoryProtocol {
    // MARK: - Dependencies

    private let remoteService: NearbyPlacesServiceProtocol

    // MARK: - Properties

    private let invalidTypes: [String]

    // MARK: - Object lifecycle

    init(remoteService: NearbyPlacesServiceProtocol, invalidTypes: [String]) {
        self.remoteService = remoteService
        self.invalidTypes = invalidTypes
    }

    // MARK: - Protocol methods

    func fetchRestaurants(latitude: String, longitude: String) async -> [Restaurant] {
        let places = await remoteService.fetchNearbyPlaces(latitude: latitude, longitude: longitude)
        return parsePlaces(places)
    }

    // MARK: - Helper methods

    private func parsePlaces(_ places: [GooglePlaceDTO]) -> [Restaurant] {
        places.compactMap { dto in
            guard let name = dto.name,
                  let rating = dto.rating,
                  let address = dto.address,
                  let types = dto.types,
                  isValid(types: types) else { return nil }

            return Restaurant(name: name, rating: rating, address: address)
        }
    }

    private func isValid(types: [String]) -> Bool {
        invalidTypes.map { types.contains($0) }.allSatisfy { $0 == false }
    }
}
