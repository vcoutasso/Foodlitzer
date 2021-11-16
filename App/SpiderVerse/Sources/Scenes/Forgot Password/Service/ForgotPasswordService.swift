import Combine
import FirebaseAuth
import Foundation

protocol ForgotPasswordServiceProtocol {
    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error>
}

final class ForgotPasswordService: ForgotPasswordServiceProtocol {
    private let auth = Auth.auth()

    func sendPasswordReset(to email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                self.auth.sendPasswordReset(withEmail: email) { error in

                    if let err = error {
                        promise(.failure(err))

                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
