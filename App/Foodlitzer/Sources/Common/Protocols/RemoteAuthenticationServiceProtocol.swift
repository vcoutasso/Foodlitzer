import Foundation

protocol RemoteAuthenticationServiceProtocol {
    var isUserSignedIn: Bool { get }

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void)
    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void)
    func signOut()
    func resetPassword()
    func editAccount(with name: String,
                     email: String,
                     completion: @escaping (AuthenticationResult) -> Void)
}
