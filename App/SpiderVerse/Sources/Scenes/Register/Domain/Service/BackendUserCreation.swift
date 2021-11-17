import Combine
import Firebase
import FirebaseDatabase
import Foundation

protocol BackendUserCreationServiceProtocol {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class BackendUserCreationService: BackendUserCreationServiceProtocol {
    // MARK: - Atributes

    let auth = Auth.auth()

    // MARK: - Public Methods

    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                self.auth.createUser(withEmail: details.email, password: details.password) { result, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        if let uid = result?.user.uid {
                            let values = [
                                Registration.Keys.name.rawValue: details.name,
                                Registration.Keys.email.rawValue: details.email,
                            ] as [String: Any]

                            Database.database()
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, _ in
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }

                        } else {
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0, userInfo: nil)))
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}