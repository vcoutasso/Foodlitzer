//
//  EditProfileView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 25/11/21.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var userName: String
    @Binding var userEmail: String
    var body: some View {
        editText
        nameField
        emailField
    }

    private var editText: some View {
        VStack {
            Text("Edit Profile")
                .font(.custom("Lora-Regular", size: 36))
        }
    }

    private var nameField: some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(Assets.Colors.unavailableGray.color)
            TextField(Localizable.Register.Name.placeholder, text: $userName)
                .frame(width: 309)
                .autocapitalization(.words)
        }.underlineTextField()
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Assets.Colors.unavailableGray.color)
            TextField(Localizable.Register.Email.placeholder, text: $userEmail)
                .frame(width: 309)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    // .foregroundColor(viewModel.shouldPromptInvalidEmail ? .red : .clear)
                )
        }.underlineTextField()
    }
}
