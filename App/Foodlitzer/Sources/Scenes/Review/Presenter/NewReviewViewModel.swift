import SwiftUI

protocol NewReviewViewModelProtocol: ObservableObject {
    var ambientLighting: CGFloat { get set }
    var waitingTime: CGFloat { get set }
    var ambientNoise: CGFloat { get set }
    var userVideos: [Data] { get set }
    var userPhotos: [UIImage] { get set }
    var userTags: [String] { get set }
    var userRating: Int { get set }
    var query: String { get set }
    var currentTag: String { get set }
    var canSliderMove: Bool { get }

    func getValue(_ value: CGFloat) -> CGFloat
    func sendReview()
}

final class NewReviewViewModel: NewReviewViewModelProtocol {
    // MARK: - Properties

    @Published var ambientLighting: CGFloat
    @Published var waitingTime: CGFloat
    @Published var ambientNoise: CGFloat
    @Published var userVideos: [Data]
    @Published var userPhotos: [UIImage]
    @Published var userTags: [String]
    @Published var userRating: Int
    @Published var query: String
    @Published var currentTag: String
    @Published var canSliderMove: Bool = true

    // MARK: - Dependencies

    private let saveReviewUseCase: SaveReviewUseCaseProtocol
    private let saveMediaUseCase: SaveMediaUseCaseProtocol

    // MARK: - Initialization

    init(saveReviewUseCase: SaveReviewUseCaseProtocol,
         saveMediaUseCase: SaveMediaUseCaseProtocol) {
        self.ambientLighting = 0
        self.waitingTime = 0
        self.ambientNoise = 0
        self.userVideos = []
        self.userPhotos = []
        self.userTags = []
        self.userRating = 0
        self.canSliderMove = true
        self.query = ""
        self.currentTag = ""
        self.saveReviewUseCase = saveReviewUseCase
        self.saveMediaUseCase = saveMediaUseCase
    }

    func getValue(_ value: CGFloat) -> CGFloat {
        // FIXME: What does 171 mean??
        value / (UIScreen.main.bounds.width - 171) // main.bounds slider + raio do Circle
    }

    func sendReview() {
        let id = "ChIJ09ULNYT73JQRH-GR32A5c18"
        let review = Review(restaurantID: id,
                            ambientLighting: getValue(ambientLighting),
                            waitingTime: getValue(waitingTime),
                            ambientNoise: ambientNoise,
                            userVideos: userVideos,
                            userPhotos: userPhotos,
                            userTags: userTags,
                            userRating: userRating)
        let images = userPhotos.compactMap { RestaurantImageDTO(imageData: $0.compressedJPEG()!) }
        let videos = userVideos.map { RestaurantVideoDTO(videoData: $0) }

        // FIXME: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        saveReviewUseCase.execute(review: review, for: id)
        saveMediaUseCase.execute(images: images, videos: videos, for: id)
    }
}

enum NewReviewViewModelFactory {
    static func make() -> NewReviewViewModel {
        let reviewDatabaseService = FirebaseDatabaseService<ReviewDTO>()
        let saveReviewService = SaveReviewService(reviewsDatabaseService: reviewDatabaseService)
        let saveReviewUseCase = SaveReviewUseCase(saveReviewService: saveReviewService)
        let imageDatabaseService = FirebaseDatabaseService<RestaurantImageDTO>()
        let videoDatabaseService = FirebaseDatabaseService<RestaurantVideoDTO>()
        let saveMediaUseCase = SaveMediaUseCase(imageDatabaseService: imageDatabaseService,
                                                videoDatabaseService: videoDatabaseService)

        return NewReviewViewModel(saveReviewUseCase: saveReviewUseCase, saveMediaUseCase: saveMediaUseCase)
    }
}
