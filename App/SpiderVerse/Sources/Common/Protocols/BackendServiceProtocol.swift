import Foundation

protocol BackendServiceProtocol {
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void)
    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void)
    func updateDisplayName(with name: String,
                           completion: @escaping (Error?) -> Void)
    func signOut()
    func resetPassword()
}
