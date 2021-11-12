import SwiftUI

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType

    var body: some View {
        NavigationView {
            if viewModel.isSignedIn {
                VStack {
                    Text("You're signed in")

                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Log out")
                    }
                }
            } else {
                VStack {
                    TextField("E-mail Adress", text: $viewModel.email)
                        .padding()
                        .background(Color(.secondarySystemBackground))

                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))

                    Button {
                        viewModel.signIn()

                    } label: {
                        Text("Sign In")
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                    }
                    .disabled(viewModel.isButtonDisabled)
                }
                .padding()
                .navigationTitle("Sign In")
            }
        }
    }
}

#if DEBUG
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView(viewModel: SignInViewModel())
        }
    }
#endif
