//
//  SignInViewModel.swift
//  Spider-Verse
//
//  Created by Eros Maurilio on 11/11/21.
//

import FirebaseAuth
import Foundation

class SignInViewModel: ObservableObject {
    @Published var signedIn = false
    let auth = Auth.auth()

    var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }

    func logOut() {
        try? auth.signOut()
    }
}
