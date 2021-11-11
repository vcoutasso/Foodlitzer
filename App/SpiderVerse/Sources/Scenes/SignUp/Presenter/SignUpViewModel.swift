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
        return validate(email, with: RegExPatterns.email)
    }

    func isValid(password: String) -> Bool {
        validate(password, with: RegExPatterns.password)
    }

    // MARK: - Helper methods

    private func validate(_ candidate: String, with regEx: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: candidate)
    }
}

// FIXME: This should probably be elsewhere. Possibly Strings.strings
private enum RegExPatterns {
    static let email = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
    static let password = #"^.(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#$%&? "]).*$"]"#
}
