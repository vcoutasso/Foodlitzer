import Combine

protocol RegisterViewModelProtocol: ObservableObject {
    // User input
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    // Registration state
    var state: Registration.State { get }
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

    // MARK: - Stored Variables

    private(set) var state: Registration.State = .notAvaliable
    private(set) var userDetails = RegistrationDetails.new

    // MARK: - Private Atributes

    private var subscription = Set<AnyCancellable>()
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

    var passwordsMatch: Bool {
        passwordText == confirmPasswordText
    }

    var isEmailValid: Bool {
        isValid(email: emailText)
    }

    var isPasswordValid: Bool {
        isValid(password: passwordText)
    }

    // MARK: - Dependencies

    private let emailValidationService: ValidateEmailUseCaseProtocol
    private let passwordValidationService: ValidatePasswordUseCaseProtocol
    private let backendService: BackendUserCreationServiceProtocol

    // MARK: - Object lifecycle

    init(emailValidationService: ValidateEmailUseCaseProtocol,
         passwordValidationService: ValidatePasswordUseCaseProtocol,
         backendService: BackendUserCreationServiceProtocol) {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
        self.invalidAttempt = false
        self.backendService = backendService
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

            userDetails.email = emailText
            userDetails.password = passwordText
            userDetails.name = nameText

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

    private func createAccount() {
        backendService
            .register(with: userDetails)
            .sink { [weak self] result in
                switch result {
                case let .failure(error):
                    self?.state = .failed(error: error)
                    debugPrint(error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscription)
    }
}

// MARK: - View Model Factory

enum RegisterViewModelFactory {
    static func make() -> RegisterViewModel {
        RegisterViewModel(emailValidationService: ValidateEmailUseCase(),
                          passwordValidationService: ValidatePasswordUseCase(),
                          backendService: BackendUserCreationService())
    }
}
