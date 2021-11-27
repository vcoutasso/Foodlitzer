import SwiftUI

protocol NewReviewViewModelProtocol: ObservableObject {
    var ambientLighting: CGFloat { get set }
    var waitingTime: CGFloat { get set }
    var ambientNoise: CGFloat { get set }
    var userVideos: [URL] { get set }
    var userPhotos: [UIImage] { get set }
    var userTags: [String] { get set }
    var userRating: Int { get set }
    var query: String { get set }
    var currentTag: String { get set }
    var canSliderMove: Bool { get }
    var isRecordingButtonActive: Bool { get }
    var soundSamplesCount: Int { get }
    var readingsInfo: [SoundSampleInfo] { get }

    func getValue(_ value: CGFloat) -> CGFloat
    func sendReview()
    func recordAudio()
}

final class NewReviewViewModel: NewReviewViewModelProtocol {
    // MARK: - Properties

    @Published var ambientLighting: CGFloat
    @Published var waitingTime: CGFloat
    @Published var ambientNoise: CGFloat
    @Published var userVideos: [URL]
    @Published var userPhotos: [UIImage]
    @Published var userTags: [String]
    @Published var userRating: Int
    @Published var query: String
    @Published var currentTag: String
    @Published var canSliderMove: Bool = true
    @Published var isRecordingButtonActive: Bool = true

    var soundSamplesCount: Int {
        micRecordingService?.numberOfSamples ?? 0
    }

    var readingsInfo: [SoundSampleInfo] {
        micRecordingService?.normalizedSoundLevels ?? []
    }

    // MARK: - Dependencies

    @Published private var micRecordingService: LoudnessEvaluationService?
    private let saveReviewUseCase: SaveReviewUseCaseProtocol
    private let saveMediaUseCase: SaveMediaUseCaseProtocol

    // MARK: - Initialization

    init(saveReviewUseCase: SaveReviewUseCaseProtocol,
         saveMediaUseCase: SaveMediaUseCaseProtocol,
         micRecordingService: LoudnessEvaluationService?) {
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
        self.micRecordingService = micRecordingService
    }

    func getValue(_ value: CGFloat) -> CGFloat {
        // FIXME: What does 171 mean??
        value / (UIScreen.main.bounds.width - 171) // main.bounds slider + raio do Circle
    }

    func sendReview() {
        // FIXME: This should represent the actual restaurant id
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
        let videos = userVideos.map { RestaurantVideoDTO(url: $0, videoData: nil) }

        saveReviewUseCase.execute(review: review, for: id)
        saveMediaUseCase.execute(images: images, videos: videos, for: id)
    }

    func recordAudio() {
        isRecordingButtonActive = false
        micRecordingService?.execute { [weak self] in
            self?.objectWillChange.send()
        } completion: { [weak self] in
            guard let self = self else { return }

            self.isRecordingButtonActive = true
            self.ambientNoise = CGFloat(self.readingsInfo
                .map { $0.level }
                .reduce(0.0, +) / Float(self.readingsInfo.count)) / 50
        }
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
        let microphoneService = LoudnessEvaluationService()
        return NewReviewViewModel(saveReviewUseCase: saveReviewUseCase,
                                  saveMediaUseCase: saveMediaUseCase,
                                  micRecordingService: microphoneService)
    }
}
