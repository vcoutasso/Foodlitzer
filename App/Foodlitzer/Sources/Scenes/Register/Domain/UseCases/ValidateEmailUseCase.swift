import Foundation

protocol ValidateEmailUseCaseProtocol {
    func execute(using email: String) -> Bool
}

@available(*, deprecated, message: "Validate with Firebase instead")
final class ValidateEmailUseCase: ValidateEmailUseCaseProtocol & RegExValidationProtocol {
    // MARK: - Private attributes

    private let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

    // MARK: - Use case methods

    func execute(using email: String) -> Bool {
        validate(email, with: regex)
    }
}
