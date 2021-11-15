import Firebase
import SwiftUI

@main
struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceUseCase()

    var body: some Scene {
        WindowGroup {
            let usecase = SignInUseCase()
            let viewModel = SignInViewModel(backendAuthService: usecase)

            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    ProfileView()
                        .environmentObject(sessionService)
                case .loggedOut:
                    SignInViewTest(viewModel: viewModel)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        FirebaseApp.configure()
        return true
    }
}
