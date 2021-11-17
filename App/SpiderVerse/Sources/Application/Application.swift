import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let sessionService = SessionServiceUseCase()

            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    let viewModel = ProfileViewModel(sessionService: sessionService)
                    ProfileView(viewModel: viewModel)
                case .loggedOut:
                    let viewModel = SignInViewModel(authenticationService: AuthenticationService())
                    SignInView(viewModel: viewModel)
                }
            }
        }
    }
}
