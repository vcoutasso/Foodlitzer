import Combine
import MapKit

final class PlacesListViewModel: ObservableObject {
    // MARK: Published properties

    @Published var places: [GooglePlace] = []

    // MARK: - Private properties

    private var locationManager: CLLocationManager?
    private var nearbyPlacesService: NearbyPlacesServiceProtocol

    // MARK: Object lifecycle

    init(nearbyPlacesService: NearbyPlacesServiceProtocol) {
        self.nearbyPlacesService = nearbyPlacesService
    }

    func handleButtonTapped() {
        if isLocationServicesEnabled() {
            Task(priority: .medium) { [weak self] in
                self?.places = await nearbyPlacesService.getNearbyPlaces(latitude: "-25.4386042",
                                                                         longitude: "-49.2688011")
                print(self?.places)
            }
        }
    }

    func isLocationServicesEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationAuthorization()
            return true
        } else {
            debugPrint("Localition services disabled")
            return false
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            debugPrint("Location authorization status restricted")
        case .denied:
            debugPrint("Location authorization status denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
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
