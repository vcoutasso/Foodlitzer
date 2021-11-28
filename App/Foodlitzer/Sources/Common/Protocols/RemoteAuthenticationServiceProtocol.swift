import Foundation

protocol RemoteAuthenticationServiceProtocol {
    var isUserSignedIn: Bool { get }
    var currentUser: AppUser? { get }

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationError?) -> Void)
    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationError?) -> Void)
    func signOut()
    func resetPassword()
    func editAccount(with name: String,
                     email: String,
                     completion: @escaping (AuthenticationError?) -> Void)
}
