import GooglePlaces
import SwiftUI

@main
struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        let path = Bundle.main.path(forResource: "GooglePlaces-info", ofType: "plist")
        print(path)
        let xml = FileManager.default.contents(atPath: path!)
        print(xml)
        let api_key = try? PropertyListSerialization.propertyList(from: xml!,
                                                                  options: .mutableContainersAndLeaves,
                                                                  format: nil) as? [String]
        print(api_key)
        GMSPlacesClient.provideAPIKey(api_key!.first!)
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = SignInViewModel()
            SignInView(viewModel: viewModel)
        }
    }
}
