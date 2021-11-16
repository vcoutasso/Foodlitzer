import Combine
import Foundation

protocol SignUpViewModelProtocol: ObservableObject {
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    var state: Registration.State { get }
    var passwordsMatch: Bool { get }

    func signUp()
    func isValid(email: String) -> Bool
    func isValid(password: String) -> Bool
}

final class SignUpViewModel: SignUpViewModelProtocol {
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

    private func register() {
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

    func signUp() {
        if passwordsMatch {
            userDetails.email = emailText
            userDetails.password = passwordText
            userDetails.name = nameText

            register()
        }
    }
}
