import Foundation

struct RegistrationDetails {
    var name: String
    var email: String
    var password: String
}

extension RegistrationDetails {
    static var new: RegistrationDetails {
        RegistrationDetails(name: "",
                            email: "",
                            password: "")
    }
}
