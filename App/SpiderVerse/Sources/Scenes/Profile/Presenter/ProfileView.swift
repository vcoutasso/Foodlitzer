import SwiftUI

struct ProfileView<ViewModelType>: View where ViewModelType: ProfileViewModelProtocol {
    // MARK: - View model

    @ObservedObject private(set) var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            Text("Name: \(viewModel.userName ?? "N/A")")
                .padding()
            Text("Email: \(viewModel.userEmail ?? "N/A")")
                .padding()

            Button {
                // TODO: This should take the user back to the login screen
                viewModel.signOut()
            } label: {
                Text("Logout")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .padding(.vertical, 16)
        }
    }
}

#if DEBUG
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView(viewModel: ProfileViewModel(authenticationService: AuthenticationService()))
        }
    }
#endif
