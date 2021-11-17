import Combine
import Foundation

protocol RegisterViewModelProtocol: ObservableObject {
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    var state: Registration.State { get }
    var passwordsMatch: Bool { get }

    func register()
    func isValid(email: String) -> Bool
    func isValid(password: String) -> Bool
}

final class RegisterViewModel: RegisterViewModelProtocol {
    // MARK: - Published Attributes

    @Published var nameText: String
    @Published var emailText: String
    @Published var passwordText: String
    @Published var confirmPasswordText: String

    // MARK: - Stored Variables

    var state: Registration.State = .notAvaliable
    var userDetails = RegistrationDetails.new

    // MARK: - Private Atribute

    private var subscription = Set<AnyCancellable>()

    // MARK: - Computed attributes

    var passwordsMatch: Bool {
        passwordText == confirmPasswordText
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

    func register() {
        if passwordsMatch {
            userDetails.email = emailText
            userDetails.password = passwordText
            userDetails.name = nameText

            createAccount()
        }
    }

    // MARK: - Helper methods

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
