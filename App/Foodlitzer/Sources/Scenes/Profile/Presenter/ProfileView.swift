import SwiftUI

struct ProfileView<ViewModelType>: View where ViewModelType: ProfileViewModelProtocol {
    // MARK: - View model

    @State private var isLocationOn = true
    @State private var isMicOn = false

    @ObservedObject private(set) var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            Spacer()
            account
            Spacer()
            permissions
            Spacer()
            deleteButton
            signOutButton
        }.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Settings")
                            .font(.custom("Lora-Regular", size: 20))
                    }
                }
            }
    }

    private var account: some View {
        VStack {
            Text("Account")
                .font(.sfCompactText(.light, size: 18))
                .foregroundColor(Color.black)
                .background(Rectangle()
                    .strokeBorder(Color.black, lineWidth: 0.5)
                    .frame(width: 195, height: 31)
                    .background(Color.white))
                .zIndex(10)

            VStack {
                HStack {
                    Text("Name: \(viewModel.userName ?? "N/A")")
                        .font(.sfCompactText(.regular, size: 24))
                    EditProfileButtonView(destination: { EditProfileView(userName: $viewModel.editingName,
                                                                         userEmail: $viewModel.editingEmail)
                    })
                }
                Text("Email: \(viewModel.userEmail ?? "N/A")")
                    .padding()
            }.background(Rectangle()
                .strokeBorder(lineWidth: 0.5)
                .frame(width: 324, height: 140))
        }
    }

    private var permissions: some View {
        VStack {
            permissionTitle.zIndex(10)
            VStack {
                permissionsLocation
                Rectangle()
                    .frame(width: 312, height: 0.5)
                    .background(Color.black)
                permissionsMic
                Rectangle()
                    .frame(width: 312, height: 0.5)
                    .background(Color.black)
                permissionsPlaceholder
            }.background(Rectangle()
                .strokeBorder(lineWidth: 0.5)
                .frame(width: 324, height: 182))
        }.padding()
    }

    private var permissionTitle: some View {
        Text("Permissions")
            .font(.sfCompactText(.light, size: 18))
            .foregroundColor(Color.black)
            .background(Rectangle()
                .strokeBorder(Color.black, lineWidth: 0.5)
                .frame(width: 195, height: 31)
                .background(Color.white))
    }

    private var permissionsLocation: some View {
        HStack {
            Image(systemName: "mappin")
                .frame(width: 38, height: 38)
            Text("LOCALIZATION")
                .font(.sfCompactText(.regular, size: 14))
                .frame(width: 200)
            Toggle("", isOn: $isLocationOn)
                .tint(.black)

        }.frame(width: 300)
    }

    private var permissionsMic: some View {
        HStack {
            Image(systemName: "mic.fill")
                .frame(width: 38, height: 38)
            Text("MIC")
                .font(.sfCompactText(.regular, size: 14))
                .frame(width: 200)
            Toggle("", isOn: $isMicOn)
                .tint(.black)

        }.frame(width: 300)
    }

    private var permissionsPlaceholder: some View {
        HStack {
            Image(systemName: "gear")
                .frame(width: 38, height: 38)
            Text("PLACEHOLDER")
                .font(.sfCompactText(.regular, size: 14))
                .frame(width: 200)
            Toggle("", isOn: $isMicOn)
                .tint(.black)

        }.frame(width: 300)
    }

    private var deleteButton: some View {
        Button {
            viewModel.delete()
        } label: {
            Text("Delete Account")
                .frame(width: 302, height: 40)
                .foregroundColor(.black)
                .overlay(Rectangle()
                    .stroke(Color.black, lineWidth: 0.5))
        }
        .padding(.vertical, 16)
    }

    private var signOutButton: some View {
        Button {
            viewModel.signOut()
        } label: {
            Text("Logout")
                .frame(width: 302, height: 40)
                .foregroundColor(.white)
                .background(Color.black)
        }
        .padding(.vertical, 16)
    }
}

#if DEBUG
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView(viewModel: ProfileViewModel(authenticationService: AuthenticationService.shared))
        }
    }
#endif
