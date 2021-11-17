import Combine

protocol RegisterViewModelProtocol: ObservableObject {
    // User input
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    // Presentation logic
    var shouldPromptInvalidEmail: Bool { get }
    var shouldPromptInvalidPassword: Bool { get }
    var shouldPromptPasswordMismatch: Bool { get }
    // View model methods
    func handleRegisterButtonTapped()
}

final class RegisterViewModel: RegisterViewModelProtocol {
    // MARK: - Published Attributes

    @Published var nameText: String
    @Published var emailText: String
    @Published var passwordText: String
    @Published var confirmPasswordText: String

    // MARK: - Private Atributes

    private var invalidAttempt: Bool

    // MARK: - Computed variables

    var shouldPromptInvalidEmail: Bool {
        invalidAttempt && !isEmailValid
    }

    var shouldPromptInvalidPassword: Bool {
        invalidAttempt && !isPasswordValid
    }

    var shouldPromptPasswordMismatch: Bool {
        invalidAttempt && !passwordsMatch
    }

    private var passwordsMatch: Bool {
        passwordText == confirmPasswordText
    }

    private var isEmailValid: Bool {
        isValid(email: emailText)
    }

    private var isPasswordValid: Bool {
        isValid(password: passwordText)
    }

    // MARK: - Dependencies

    private let emailValidationService: ValidateEmailUseCaseProtocol
    private let passwordValidationService: ValidatePasswordUseCaseProtocol
    private let authenticationService: AuthenticationServiceProtocol

    // MARK: - Object lifecycle

    init(emailValidationService: ValidateEmailUseCaseProtocol,
         passwordValidationService: ValidatePasswordUseCaseProtocol,
         authenticationService: AuthenticationServiceProtocol) {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
        self.invalidAttempt = false
        self.authenticationService = authenticationService
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

    // MARK: - Account creation

    func handleRegisterButtonTapped() {
        if isAttemptValid() {
            invalidAttempt = false

            createAccount()
        } else {
            invalidAttempt = true
        }

        objectWillChange.send()
    }

    // MARK: - Helper methods

    private func isAttemptValid() -> Bool {
        isEmailValid && isPasswordValid && passwordsMatch
    }

    // TODO: Improve validation handling
    private func createAccount() {
        authenticationService.createAccount(withEmail: emailText, password: passwordText) { [weak self] result in
            switch result {
            case .success:
                self?.setUserDisplayName()
            case .failure:
                self?.invalidAttempt = true
            }
        }
    }

    private func setUserDisplayName() {
        authenticationService.updateCurrentUserDisplayName(with: nameText) { [weak self] error in
            if error == nil {
                // TODO: Go to home
            } else {
                self?.invalidAttempt = true
            }
        }
    }
}

// MARK: - View Model Factory

enum RegisterViewModelFactory {
    static func make() -> RegisterViewModel {
        RegisterViewModel(emailValidationService: ValidateEmailUseCase(),
                          passwordValidationService: ValidatePasswordUseCase(),
                          authenticationService: AuthenticationService())
    }
}
