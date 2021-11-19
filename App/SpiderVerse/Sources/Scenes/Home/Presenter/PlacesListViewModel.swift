import MapKit

final class PlacesListViewModel: ObservableObject {
    // MARK: - Private properties

    private var locationManager: CLLocationManager
    private var nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol

    // MARK: Object lifecycle

    init(nearbyRestaurantsUseCase: FetchNearbyRestaurantsUseCaseProtocol) {
        self.locationManager = CLLocationManager()
        self.nearbyRestaurantsUseCase = nearbyRestaurantsUseCase
    }

    // MARK: - View events

    func handleOnApper() {
        checkIfLocationServicesAreEnabled()
    }

    func handleButtonTapped(completion: @escaping ([PlacesListView.Model]) -> Void) {
        if let coordinate = locationManager.location?.coordinate {
            let latitude = coordinate.latitude.description
            let longitude = coordinate.longitude.description

            Task(priority: .medium) {
                let restaurants = await nearbyRestaurantsUseCase.execute(latitude: latitude, longitude: longitude)
                completion(restaurants.map { .init(name: $0.name, address: $0.address) })
            }
        }
    }

    func checkIfLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorizationStatus()
        } else {
            debugPrint("Location services disabled")
        }
    }

    private func checkLocationAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            debugPrint("Location authorization status restricted")
        case .denied:
            debugPrint("Location authorization status denied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

enum PlacesListViewModelFactory {
    static func make() -> PlacesListViewModel {
        let remoteService = NearbyPlacesService()
        let invalidTypes = ["lodging"]
        let repository = NearbyRestaurantRepository(remoteService: remoteService, invalidTypes: invalidTypes)
        let useCase = FetchNearbyRestaurantsUseCase(repository: repository)

        return PlacesListViewModel(nearbyRestaurantsUseCase: useCase)
    }
}
