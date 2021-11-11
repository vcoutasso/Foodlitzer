//
//  SignInViewTest.swift
//  Spider-Verse
//
//  Created by Eros Maurilio on 11/11/21.
//

import SwiftUI

struct SignInViewTest: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var viewModel: SignInViewModel

    var body: some View {
        NavigationView {
            if viewModel.isSignedIn {
                VStack {
                    Text("You're signed in")

                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Log out")
                    }
                }
            } else {
                VStack {
                    TextField("E-mail Adress", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))

                    Button {
                        guard !email.isEmpty, !password.isEmpty else { return }

                        viewModel.signIn(email: email, password: password)

                    } label: {
                        Text("Sign In")
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                    }
                }
                .padding()
                .navigationTitle("Sign In")
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
