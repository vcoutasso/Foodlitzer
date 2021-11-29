import Combine
import Foundation

protocol SearchViewModelProtocol: ObservableObject {
    var cardModels: [ListCard.CardModel] { get }
    var searchText: String { get set }

    func updateResults() async
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: - Properties

    @Published var cardModels = [ListCard.CardModel]()
    @Published var searchText: String = "" {
        didSet {
            subject.send()
        }
    }

    private var cancellable: AnyCancellable?
    private lazy var subject: PassthroughSubject<Void, Never> = {
        let subject = PassthroughSubject<Void, Never>()
        cancellable = subject.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { _ in
                Task {
                    await self.updateResults()
                }
            }

        return subject
    }()

    // MARK: - Dependencies

    private let restaurantQueryUseCase: RestaurantQueryUseCaseProtocol

    // MARK: - Initialization

    init(restaurantQueryUseCase: RestaurantQueryUseCaseProtocol) {
        self.restaurantQueryUseCase = restaurantQueryUseCase
    }

    deinit {
        cancellable?.cancel()
    }

    // MARK: - Update results

    func updateResults() async {
        let field = "name"
        let dtos = await restaurantQueryUseCase.execute(query: searchText, for: field)

        DispatchQueue.main.async {
            self.cardModels = dtos.map { .init(name: $0.name,
                                               rating: Int($0.rating),
                                               address: $0.address,
                                               price: $0.priceLevel,
                                               restaurantID: $0.id!) }
        }
    }
}

enum SearchViewModelFactory {
    static func make() -> SearchViewModel {
        let databaseService = FirebaseDatabaseService<RestaurantInfoDTO>()
        let queryUseCase = RestaurantQueryUseCase(restaurantDatabaseService: databaseService)

        return .init(restaurantQueryUseCase: queryUseCase)
    }
}
