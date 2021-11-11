//
//  SignUpView.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 11/11/21.
//

import SwiftUI

struct SignUpView<ViewModel>: View where ViewModel: SignUpViewModelProtocol {
    @ObservedObject var viewModel: ViewModel

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
