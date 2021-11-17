import SwiftUI

struct ForgotPasswordView<ViewModelType>: View where ViewModelType: ForgotPasswordViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.title)

            TextField("E-mail Adress", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button {
                viewModel.sendPasswordReset()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Send Password Reset")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: ForgotPasswordViewModel(authenticationService: AuthenticationService()))
    }
}
