import Firebase
import GooglePlaces
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        // GooglePlaces configuration
        guard let path = Bundle.main.path(forResource: "GooglePlaces-info", ofType: "plist"),
              let plistContent = NSDictionary(contentsOfFile: path),
              let placesAPIKey = plistContent["API_KEY"] as? String else { return false }

        GMSPlacesClient.provideAPIKey(placesAPIKey)

        // Firebase configuration
        FirebaseApp.configure()

        return true
    }
}
