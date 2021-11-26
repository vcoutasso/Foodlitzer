import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @StateObject private var authenticationService = AuthenticationService.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authenticationService.isUserSignedIn {
                    LandigPageView()
                } else {
                    OnboardingView(viewModel: OnboardingViewModel())
//                    LandigPageView()
                }
            }
        }
    }
}
