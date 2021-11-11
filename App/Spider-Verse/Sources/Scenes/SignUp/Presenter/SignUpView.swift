import SwiftUI

struct SignUpView<ViewModelType>: View where ViewModelType: SignUpViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType

    var body: some View {
        VStack {
            TextField(Localizable.SignUp.Name.placeholder, text: $viewModel.nameText)
            TextField(Localizable.SignUp.Email.placeholder, text: $viewModel.emailText)
            TextField(Localizable.SignUp.Password.placeholder, text: $viewModel.passwordText)
            TextField(Localizable.SignUp.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
