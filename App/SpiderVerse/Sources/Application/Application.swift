import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @StateObject private var authenticationService = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authenticationService.isUserSignedIn {
                    let viewModel = ProfileViewModel(authenticationService: authenticationService)
                    ProfileView(viewModel: viewModel)
                } else {
                    // let viewModel = SignInViewModel(authenticationService: authenticationService)
                    // SignInView(viewModel: viewModel)
                    let viewModel = PlacesListViewModel(nearbyPlacesService: NearbyPlacesService())
                    PlacesListView(viewModel: viewModel)
                }
            }
        }
    }
}
