import Foundation

protocol RegExValidationProtocol {
    func validate(_ candidate: String, with regEx: String) -> Bool
}

extension RegExValidationProtocol {
    func validate(_ candidate: String, with regEx: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: candidate)
    }
}
