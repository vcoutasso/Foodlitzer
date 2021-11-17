import Combine
import Foundation
protocol ForgotPasswordViewModelProtocol: ObservableObject {
    var service: ForgotPasswordServiceProtocol { get }
    var email: String { get set }

    func sendPasswordReset()
}

final class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    @Published var email: String

    var service: ForgotPasswordServiceProtocol
    private var subscription = Set<AnyCancellable>()

    init(service: ForgotPasswordServiceProtocol) {
        self.email = ""
        self.service = service
    }

    func sendPasswordReset() {
        service
            .sendPasswordReset(to: email)
            .sink { res in

                switch res {
                case let .failure(err):
                    print("Failed: \(err)")

                default: break
                }
            } receiveValue: {
                print("Sent password reset Request")
            }
            .store(in: &subscription)
    }
}

// MARK: - View Model Factory

enum ForgotPasswordViewModelFactory {
    static func make() -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(service: ForgotPasswordService())
    }
}
