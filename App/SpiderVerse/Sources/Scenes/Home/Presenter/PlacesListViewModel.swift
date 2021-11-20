import Foundation

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

            Task(priority: .medium) {
                let restaurants = await nearbyRestaurantsUseCase.execute(latitude: latitudeDescription,
                                                                         longitude: longitudeDescription)
                completion(restaurants.map { .init(name: $0.name, address: $0.address) })
            }
        }
    }
}

enum PlacesListViewModelFactory {
    static func make() -> PlacesListViewModel {
        let remoteService = NearbyPlacesService()
        let invalidTypes = ["lodging"]
        let repository = NearbyRestaurantRepository(remoteService: remoteService, invalidTypes: invalidTypes)
        let userLocationUseCase = UserLocationUseCase()
        let nearbyRestaurantsUseCase = FetchNearbyRestaurantsUseCase(repository: repository)

        return PlacesListViewModel(userLocationUseCase: userLocationUseCase,
                                   nearbyRestaurantsUseCase: nearbyRestaurantsUseCase)
    }
}
