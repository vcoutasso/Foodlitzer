import Combine

protocol OnboardingViewModelProtocol: ObservableObject {
    var currentPage: Int { get set }
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    // MARK: Published attributes

    @Published var currentPage: Int

    // MARK: Object lifecycle

    init() {
        self.currentPage = 0
    }
}

enum OnboardingViewModelFactory {
    static func make() -> OnboardingViewModel {
        .init()
    }
}
