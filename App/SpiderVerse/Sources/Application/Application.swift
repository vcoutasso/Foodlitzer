import SwiftUI

struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let usecase = SignInUseCase()
            let viewModel = SignInViewModel(backendAuthService: usecase)
            let sessionService = SessionServiceUseCase()

            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    ProfileView(viewModel: ProfileViewModel(sessionService: sessionService))
                case .loggedOut:
                    SignInView(viewModel: viewModel)
                }
            }
        }
    }
}
