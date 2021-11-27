import SwiftUI

struct EditProfileView: View {
    @Binding var userName: String
    @Binding var userEmail: String
    var edit: () -> Void
    @Environment(\.presentationMode) var presentationMode

    let nameHolder: String
    let userHolder: String

    var body: some View {
        VStack {
            editText
            nameField
            emailField
            button
            Spacer()
        }
        .padding(.horizontal, 45)
    }

    private var editText: some View {
        VStack {
            Text("Edit Profile")
                .font(.lora(.regular, size: 36))
                .padding(.top, 15)
        }
    }

    private var nameField: some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(nameHolder, text: $userName)
                .autocapitalization(.words)
        }
        .underlineTextField()
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(userHolder, text: $userEmail)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
        }
        .underlineTextField()
        .padding(.bottom, 65)
    }

    private var button: some View {
        DefaultButton(label: "OK") {
            edit() // FIXME: chama o método, mas muda nao os dados de conta
            presentationMode.wrappedValue.dismiss()
        }
    }
}
