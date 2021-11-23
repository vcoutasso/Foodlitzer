import Foundation

protocol ValidatePasswordUseCaseProtocol {
    func execute(using password: String) -> Bool
}

@available(*, deprecated, message: "Validate with Firebase instead")
final class ValidatePasswordUseCase: ValidatePasswordUseCaseProtocol & RegExValidationProtocol {
    // MARK: - Private attributes

    private let regex = #"^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#$%&? "]).*$"#

    // MARK: - Use case methods

    func execute(using password: String) -> Bool {
        validate(password, with: regex)
    }
}
