import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @StateObject private var authenticationService = AuthenticationService.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authenticationService.isUserSignedIn {
                    PlacesListView(viewModel: PlacesListViewModelFactory.make())
                } else {
                    OnboardingView(viewModel: OnboardingViewModel())
                }
            }
        }
    }
}