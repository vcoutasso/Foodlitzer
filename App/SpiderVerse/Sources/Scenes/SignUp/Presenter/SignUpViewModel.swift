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

    // MARK: - Dependencies

    private var emailValidationService: ValidateEmailUseCaseProtocol
    private var passwordValidationService: ValidatePasswordUseCaseProtocol

    // MARK: - Object lifecycle

    init(emailValidationService: ValidateEmailUseCaseProtocol,
         passwordValidationService: ValidatePasswordUseCaseProtocol) {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
        self.emailValidationService = emailValidationService
        self.passwordValidationService = passwordValidationService
    }

    // MARK: - Validation methods

    func isValid(email: String) -> Bool {
        emailValidationService.execute(using: email)
    }

    func isValid(password: String) -> Bool {
        passwordValidationService.execute(using: password)
    }
}
