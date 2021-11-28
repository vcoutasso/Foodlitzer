import SwiftUI

struct ForgotPasswordView<ViewModelType>: View where ViewModelType: ForgotPasswordViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            Text("Forgot Password")
                .font(.custom("Lora-Regular", size: 24))

            HStack {
                Image(systemName: "lock")
                    .foregroundColor(Color(Assets.Colors.unavailableGray))
                TextField("E-mail Adress", text: $viewModel.email)
                    .frame(width: 286)
                    .keyboardType(.emailAddress)
                    .padding()

            }.underlineTextField(isEditing: false)

            Button {
                viewModel.sendPasswordReset()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Send e-mail")
                    .frame(width: 302, height: 40)
                    .foregroundColor(.white)
                    .background(Color.black)
            }.padding(.top, 30)
        }
    }
}

#if DEBUG
    struct ForgotPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            ForgotPasswordView(viewModel: ForgotPasswordViewModel(authenticationService: AuthenticationService.shared))
        }
    }
#endif
