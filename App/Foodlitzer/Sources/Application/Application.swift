import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @StateObject private var authenticationService = AuthenticationService.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authenticationService.isUserSignedIn {
                    LandingPageView()
                } else {
                    OnboardingView(viewModel: OnboardingViewModel())
                }
            }
        }
    }
}
