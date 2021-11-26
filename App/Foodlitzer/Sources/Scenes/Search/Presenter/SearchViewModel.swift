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
            Task {
                await self.updateResults()
            }
        }
    }

    // MARK: - Dependencies

    private let restaurantQueryUseCase: RestaurantQueryUseCaseProtocol

    // MARK: - Initialization

    init(restaurantQueryUseCase: RestaurantQueryUseCaseProtocol) {
        self.restaurantQueryUseCase = restaurantQueryUseCase
    }

    // MARK: - Update results

    func updateResults() async {
        let field = "name"
        let dtos = await restaurantQueryUseCase.execute(query: searchText, for: field)

        DispatchQueue.main.async { [weak self] in
            self?.cardModels = dtos.map { .init(name: $0.name,
                                                rating: Int($0.rating),
                                                address: $0.address,
                                                price: $0.priceLevel) }
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
