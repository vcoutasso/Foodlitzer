//
//  ProfileView.swift
//  Spider-Verse
//
//  Created by Eros Maurilio on 13/11/21.
//

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
