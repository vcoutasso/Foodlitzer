import Foundation

enum Registration {
    enum Keys: String {
        case name
        case email
        case pic
    }

    enum State {
        case successfull
        case failed(error: Error)
        case notAvaliable
    }
}
