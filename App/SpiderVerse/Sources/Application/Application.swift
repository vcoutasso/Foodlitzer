import SwiftUI

@main
struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let viewModel = SignInViewModel()
            SignInView(viewModel: viewModel)
        }
    }
}
