import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @StateObject private var authenticationService = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authenticationService.isUserSignedIn {
                    PlacesListView(viewModel: PlacesListViewModel())
                } else {
                    OnboardingView(viewModel: OnboardingViewModel())
                }
            }.environmentObject(authenticationService)
        }
    }
}
