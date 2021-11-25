import SwiftUI

protocol NewReviewViewModelProtocol: ObservableObject {
    var restaurantName: String { get set }
    var restaurantAddress: String { get set }
    var lightRate: CGFloat { get set }
    var waitRate: CGFloat { get set }
    var soundRate: CGFloat { get set }
    var userVideos: [Data] { get set }
    var userPhotos: [UIImage] { get set }
    var userTags: [String] { get set }
    var restaurantRate: Int { get set }
    var query: String { get set }
    var currentTag: String { get set }
    var canSliderMove: Bool { get }

    func getValue(_ value: CGFloat) -> String
    func sendReview()
}

final class NewReviewViewModel: NewReviewViewModelProtocol {
    // MARK: - Properties

    @Published var restaurantName: String
    @Published var restaurantAddress: String
    @Published var lightRate: CGFloat
    @Published var waitRate: CGFloat
    @Published var soundRate: CGFloat
    @Published var userVideos: [Data]
    @Published var userPhotos: [UIImage]
    @Published var userTags: [String]
    @Published var restaurantRate: Int
    @Published var query: String
    @Published var currentTag: String
    @Published var canSliderMove: Bool = true

    // MARK: - Dependencies

    private let saveReviewUseCase: SaveReviewUseCaseProtocol

    // MARK: - Initialization

    init(saveReviewUseCase: SaveReviewUseCaseProtocol) {
        self.restaurantName = ""
        self.restaurantAddress = ""
        self.lightRate = 0
        self.waitRate = 0
        self.soundRate = 0
        self.userPhotos = []
        self.userVideos = []
        self.userTags = []
        self.restaurantRate = 0
        self.canSliderMove = true
        self.query = ""
        self.currentTag = ""
        self.saveReviewUseCase = saveReviewUseCase
    }

    func getValue(_ value: CGFloat) -> String {
        let percent = value / (UIScreen.main.bounds.width - 171) // main.bounds slider + raio do Circle

        return String(format: "%.2f", percent)
    }

    func sendReview() {
        _ = Review(restaurantName: restaurantName,
                   restaurantAddress: restaurantAddress,
                   lightRate: lightRate,
                   waitRate: waitRate,
                   soundRate: soundRate,
                   userPhotos: userPhotos,
                   userTags: userTags,
                   restaurantRate: restaurantRate)
    }
}

enum NewReviewViewModelFactory {
    static func make() -> NewReviewViewModel {
        let reviewDatabaseService = FirebaseDatabaseService<ReviewDTO>()
        let saveReviewService = SaveReviewService(reviewsDatabaseService: reviewDatabaseService)
        let saveReviewUseCase = SaveReviewUseCase(saveReviewService: saveReviewService)

        return NewReviewViewModel(saveReviewUseCase: saveReviewUseCase)
    }
}
