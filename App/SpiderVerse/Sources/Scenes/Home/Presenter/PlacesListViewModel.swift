import MapKit

final class PlacesListViewModel: ObservableObject {
    // MARK: Published properties

    @Published var places: [GooglePlace] = []

    // MARK: - Private properties

    private var locationManager: CLLocationManager
    private var nearbyPlacesService: NearbyPlacesServiceProtocol

    // MARK: Object lifecycle

    init(nearbyPlacesService: NearbyPlacesServiceProtocol) {
        self.locationManager = CLLocationManager()
        self.nearbyPlacesService = nearbyPlacesService
    }

    func handleButtonTapped() {
        if let coordinate = locationManager.location?.coordinate {
            Task(priority: .medium) { [weak self] in
                self?.places = await nearbyPlacesService.getNearbyPlaces(latitude: "\(coordinate.latitude.description)",
                                                                         longitude: "\(coordinate.longitude.description)")
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
        PlacesListViewModel(nearbyPlacesService: NearbyPlacesService())
    }
}
