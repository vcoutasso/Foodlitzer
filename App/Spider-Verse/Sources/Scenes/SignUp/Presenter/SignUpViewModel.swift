import Combine
import Foundation

enum RegistrationState {
    case successfull
    case failed(error: Error)
    case notAvaliable
}

protocol SignUpViewModelProtocol: ObservableObject {
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }
    var service: BackendUserCreationServiceProtocol { get }
    var userDetails: RegistrationDetails { get }
    var state: RegistrationState { get }

    init(service: BackendUserCreationServiceProtocol)

    func register()
    func signUp()
    func isValid(email: String) -> Bool
    func isValid(password: String) -> Bool
    func passwordMatches() -> Bool
}

final class SignUpViewModel: SignUpViewModelProtocol {
    // MARK: - Published Attributes

    @Published var nameText: String
    @Published var emailText: String
    @Published var passwordText: String
    @Published var confirmPasswordText: String

    let service: BackendUserCreationServiceProtocol
    var state: RegistrationState = .notAvaliable
    var userDetails = RegistrationDetails.new

    private var subscription = Set<AnyCancellable>()

    // MARK: - Object lifecycle

    init(service: BackendUserCreationServiceProtocol) {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
        self.service = service
    }

    // MARK: - Validation methods

    func isValid(email: String) -> Bool {
        validate(email, with: Strings.RegEx.ValidationPattern.email)
    }

    func isValid(password: String) -> Bool {
        validate(password, with: Strings.RegEx.ValidationPattern.password)
    }

    func passwordMatches() -> Bool {
        passwordText == confirmPasswordText
    }

    func register() {
        service
            .register(with: userDetails)
            .sink { [weak self] result in

                switch result {
                case let .failure(error):
                    self?.state = .failed(error: error)
                    print(error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscription)
    }

    // MARK: - Helper methods

    private func validate(_ string: String, with regEx: String) -> Bool {
        NSPredicate(format: "self matches %@", regEx).evaluate(with: string)
    }

    func signUp() {
        if passwordMatches() {
            userDetails.email = emailText
            userDetails.password = passwordText
            userDetails.name = nameText

            register()
        }
    }
}
