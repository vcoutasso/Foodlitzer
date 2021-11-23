import MapKit

protocol UserLocationUseCaseProtocol {
    var isPermissionGranted: Bool { get }
    func setup()
    func execute() -> (Double, Double)?
}

final class UserLocationUseCase: UserLocationUseCaseProtocol {
    // MARK: - Properties

    private let locationManager: CLLocationManager

    var isPermissionGranted: Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            debugPrint("User location permission not granted")
            return false
        }
    }

    // MARK: - Object lifecycle

    convenience init() {
        let locationManager = CLLocationManager()
        self.init(locationManager: locationManager)
    }

    private init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
    }

    // MARK: - Use case methods

    func setup() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func execute() -> (Double, Double)? {
        guard isPermissionGranted, let coordinate = locationManager.location?.coordinate else { return nil }

        return (coordinate.latitude, coordinate.longitude)
    }
}
