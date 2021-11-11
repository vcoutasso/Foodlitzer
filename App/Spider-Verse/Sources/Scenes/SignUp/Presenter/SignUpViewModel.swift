import Foundation

protocol SignUpViewModelProtocol: ObservableObject {
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    var passwordsMatch: Bool { get }

    func isValid(email: String) -> Bool
    func isValid(password: String) -> Bool
}

final class SignUpViewModel: SignUpViewModelProtocol {
    // MARK: - Published Attributes

    @Published var nameText: String
    @Published var emailText: String
    @Published var passwordText: String
    @Published var confirmPasswordText: String

    // MARK: - Computed attributes

    var passwordsMatch: Bool {
        passwordText == confirmPasswordText
    }

    // MARK: - Object lifecycle

    init() {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
    }

    // MARK: - Validation methods

    func isValid(email: String) -> Bool {
        validate(email, with: Strings.RegEx.ValidationPattern.email)
    }

    func isValid(password: String) -> Bool {
        validate(password, with: Strings.RegEx.ValidationPattern.password)
    }

    // MARK: - Helper methods

    private func validate(_ string: String, with regEx: String) -> Bool {
        NSPredicate(format: "self matches %@", regEx).evaluate(with: string)
    }
}
