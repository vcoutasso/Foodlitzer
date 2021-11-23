import SwiftUI

struct HeaderComponent: View {
    @EnvironmentObject private var authenticationService: AuthenticationService
    var body: some View {
        HStack {
            HeaderButtonView(text: "magnifyingglass") {
                EmptyView()
            }

            Spacer()

            Text("foodlitzer")
                .font(.lora(.regular, size: 17))

            Spacer()

            HeaderButtonView(text: "gear") {
                ProfileView(viewModel: ProfileViewModelFactory.make(authenticationService: authenticationService))
            }
        }
    }
}
