
import Combine
import GooglePlaces
import MapKit

struct Place: Identifiable {
    var name: String
    var address: String
    var image: UIImage
    var attributions: NSAttributedString
    var id: String
}

class PlacesListViewModel: ObservableObject {
    @Published var places: [Place] = []

    private var placesClient: GMSPlacesClient!

    init() {
        self.placesClient = GMSPlacesClient.shared()
    }

    func handleButtonTap() {
        let placeFields: GMSPlaceField = [.name, .formattedAddress, .placeID]

        placesClient
            .findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] placeLikelihoodList, error in
                defer {
                    self?.objectWillChange.send()
                }
                guard let strongSelf = self else {
                    return
                }

                guard error == nil else {
                    print("Current place error: \(error?.localizedDescription ?? "")")
                    return
                }

                if let placeLikelihoodList = placeLikelihoodList {
                    for likelihood in placeLikelihoodList {
                        let place = likelihood.place
                        let placeID = place.placeID ?? "Lugar"

                        let fields = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))

                        strongSelf.placesClient?.fetchPlace(fromPlaceID: placeID,
                                                            placeFields: fields,
                                                            sessionToken: nil, callback: {
                                                                (place: GMSPlace?, error: Error?) in
                                                                    if let error = error {
                                                                        print("An error occurred: \(error.localizedDescription)")
                                                                        return
                                                                    }
                                                                    if let place = place,
                                                                       let photoMetadata: GMSPlacePhotoMetadata = place
                                                                       .photos?[0] {
                                                                        // Get the metadata for the first photo in the place photo metadata list.

                                                                        // Call loadPlacePhoto to display the bitmap and attribution.
                                                                        strongSelf.placesClient?
                                                                            .loadPlacePhoto(photoMetadata,
                                                                                            callback: { photo, error -> Void in
                                                                                                if let error = error {
                                                                                                    // TODO: Handle the error.
                                                                                                    print("Error loading photo metadata: \(error.localizedDescription)")
                                                                                                    return
                                                                                                } else {
                                                                                                    // Display the first image and its attributions.
                                                                                                    let myPlace =
                                                                                                        Place(name: place
                                                                                                            .name ?? "",
                                                                                                            address: place
                                                                                                                .formattedAddress ??
                                                                                                                "",
                                                                                                            image: photo ??
                                                                                                                UIImage(),
                                                                                                            attributions: photoMetadata
                                                                                                                .attributions ??
                                                                                                                NSAttributedString(),
                                                                                                            id: placeID)
                                                                                                    strongSelf.places
                                                                                                        .append(myPlace)
                                                                                                }
                                                                                            })
                                                                    }
                                                            })
                    }
                }
            }
    }

    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationAuthorization()
        } else {
            print("alert")
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("alert")
        case .denied:
            print("alert")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}
