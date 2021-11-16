import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.title)

            TextField("E-mail Adress", text: .constant(""))
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button {
                // Reset action here
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
        ForgotPasswordView()
    }
}
