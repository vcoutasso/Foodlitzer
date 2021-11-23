import Foundation
import SwiftUI

final class PlacesListViewModel: ObservableObject {
    // MARK: - Private properties

    private var userLocationUseCase: UserLocationUseCaseProtocol
    private var nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol

    // MARK: Object lifecycle

    init(userLocationUseCase: UserLocationUseCaseProtocol,
         nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol) {
        self.userLocationUseCase = userLocationUseCase
        self.nearbyRestaurantsUseCase = nearbyRestaurantsUseCase
    }

    // MARK: - View events

    func handleOnAppear() {
        userLocationUseCase.setup()
    }

    func handleButtonTapped(completion: @escaping ([PlacesListView.Model]) -> Void) {
        if let (latitude, longitude) = userLocationUseCase.execute() {
            let latitudeDescription = latitude.description
            let longitudeDescription = longitude.description

            Task {
                let restaurants = await nearbyRestaurantsUseCase.execute(latitude: latitudeDescription,
                                                                         longitude: longitudeDescription)
                completion(restaurants.map { .init(id: $0.id!,
                                                   name: $0.name,
                                                   address: $0.address,
                                                   images: $0.imagesData.compactMap { $0.asImage() }) })
            }
        }
    }
}

enum PlacesListViewModelFactory {
    static func make() -> PlacesListViewModel {
        let databaseService = FirebaseDatabaseService()
        let photosService = PlacePhotosService()
        let placesService = NearbyPlacesService()
        let invalidTypes = ["lodging"]
        let repository = NearbyRestaurantRepository(databaseService: databaseService,
                                                    photosService: photosService,
                                                    remoteService: placesService,
                                                    invalidTypes: invalidTypes)
        let userLocationUseCase = UserLocationUseCase()
        let nearbyRestaurantsUseCase = FetchNearbyRestaurantsUseCase(repository: repository)

        return PlacesListViewModel(userLocationUseCase: userLocationUseCase,
                                   nearbyRestaurantsUseCase: nearbyRestaurantsUseCase)
    }
}
