import SwiftUI

struct SignInViewTest<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @State private var isTapped = false

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
                    .padding(.vertical, 16)

                    Button {
                        isTapped.toggle()

                    } label: {
                        Text("Sign UP")
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                    }
                }
                .padding()
                .navigationTitle("Sign In")
                .sheet(isPresented: $isTapped) {
                    let usecase = BackendUserCreationService()
                    let viewModel = SignUpViewModel(service: usecase)
                    SignUpView(viewModel: viewModel)
                }
            }
        }
    }
}
