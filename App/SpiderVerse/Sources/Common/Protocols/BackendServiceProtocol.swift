import Foundation

protocol BackendServiceProtocol {
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void)
    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void)
    func signOut()
    func resetPassword()
}
