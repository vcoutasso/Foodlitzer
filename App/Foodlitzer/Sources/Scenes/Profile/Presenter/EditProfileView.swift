import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss

    @State var userName: String = ""
    @State var userEmail: String = ""

    let commitChanges: (_ name: String, _ email: String, @escaping () -> Void) -> Void
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
        .underlineTextField(isEditing: false)
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(userHolder, text: $userEmail)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
        }
        .underlineTextField(isEditing: false)
        .padding(.bottom, 65)
    }

    private var button: some View {
        DefaultButton(label: "Save Changes") {
            // TODO: Show activity indicator
            commitChanges(userName, userEmail) {
                dismiss()
            }
        }
    }
}
