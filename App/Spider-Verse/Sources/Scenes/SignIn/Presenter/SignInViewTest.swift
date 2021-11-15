import SwiftUI

struct SignInViewTest<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @State private var isTapped = false

    var body: some View {
        VStack {
            TextField("E-mail Adress", text: $viewModel.email)
                .padding()
                .background(Color(.secondarySystemBackground))

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))

            NavigationLink {
                ProfileView(viewModel: ProfileViewModel(sessionService: SessionServiceUseCase()))
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
        .sheet(isPresented: $isTapped) {
            let usecase = BackendUserCreationService()
            let viewModel = SignUpViewModel(service: usecase)
            SignUpView(viewModel: viewModel)
        }
    }
}
