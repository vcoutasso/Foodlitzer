import Combine
import Foundation
import SwiftUI

protocol RegisterViewModelProtocol: ObservableObject {
    // User input
    var nameText: String { get set }
    var emailText: String { get set }
    var passwordText: String { get set }
    var confirmPasswordText: String { get set }

    // Presentation logic
    var didRegister: Bool { get set }
    var shouldPromptInvalidEmail: Bool { get }
    var shouldPromptInvalidPassword: Bool { get }
    var shouldPromptPasswordMismatch: Bool { get }
    var isButtonDisabled: Bool { get }
    // View model methods
    func handleRegisterButtonTapped()
}

final class RegisterViewModel: RegisterViewModelProtocol {
    // MARK: - Published Attributes

    @Published var nameText: String
    @Published var emailText: String
    @Published var passwordText: String
    @Published var confirmPasswordText: String
    @Published var didRegister: Bool = false

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

    private var isEmailValid: Bool

    private var isPasswordValid: Bool

    // MARK: - Computed Variables

    var isButtonDisabled: Bool {
        nameText.isEmpty ||
            emailText.isEmpty ||
            passwordText.isEmpty ||
            confirmPasswordText.isEmpty
    }

    // MARK: - Dependencies

    private let authenticationService: AuthenticationServiceProtocol

    // MARK: - Object lifecycle

    init(authenticationService: AuthenticationServiceProtocol) {
        self.nameText = ""
        self.emailText = ""
        self.passwordText = ""
        self.confirmPasswordText = ""
        self.invalidAttempt = false
        self.isEmailValid = false
        self.isPasswordValid = false
        self.authenticationService = authenticationService
    }

    // MARK: - Account creation

    func handleRegisterButtonTapped() {
        resetFlags()

        if isAttemptValid() {
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
        authenticationService.createAccount(with: nameText,
                                            email: emailText,
                                            password: passwordText) { [weak self] result in
            switch result {
            case let .success(user):
                debugPrint("User logged in with name: '\(user!.name))' and email: '\(user!.email)'")
                self?.didRegister = true
            case let .failure(error):
                self?.updateFailureFlags(for: error)
            }
            self?.objectWillChange.send()
        }
    }

    private func resetFlags() {
        invalidAttempt = false
        isEmailValid = true
        isPasswordValid = true
    }

    private func updateFailureFlags(for error: AuthenticationError) {
        invalidAttempt = true

        // TODO: Review if name can be flagged invalid as well
        switch error {
        case .invalidPassword:
            isPasswordValid = false
        case .invalidEmail:
            isEmailValid = false
        default:
            break
        }

        objectWillChange.send()
    }
}

// MARK: - View Model Factory

enum RegisterViewModelFactory {
    static func make() -> RegisterViewModel {
        RegisterViewModel(authenticationService: AuthenticationService.shared)
    }
}
