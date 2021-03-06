import Firebase
import GooglePlaces
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        UINavigationBar.appearance().tintColor = .black

        // Google Places API configuration
        guard let path = Bundle.main.path(forResource: Strings.GooglePlaces.infoFilename,
                                          ofType: Strings.GooglePlaces.infoFileExtension),
            let plistContent = NSDictionary(contentsOfFile: path),
            let placesAPIKey = plistContent[Strings.GooglePlaces.apiKey] as? String
        else {
            fatalError("Could not find Google Places API Key")
        }

        GMSPlacesClient.provideAPIKey(placesAPIKey)

        // Firebase configuration
        FirebaseApp.configure()

        return true
    }
}
