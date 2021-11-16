import SwiftUI

struct ProfileView<ViewModelType>: View where ViewModelType: ProfileViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelType

    var body: some View {
        VStack {
            Text("Name: \(viewModel.userName ?? "N/A")")
                .padding()
            Text("Email: \(viewModel.userEmail ?? "N/A")")
                .padding()

            Button {
                // FIXME: Não sai automaticamente, desloga da conta, porem não atualiza a viewm precisa voltar para a tela de login.
                viewModel.logOut()

            } label: {
                Text("Logout")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .padding(.vertical, 16)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(sessionService: SessionServiceUseCase()))
    }
}
