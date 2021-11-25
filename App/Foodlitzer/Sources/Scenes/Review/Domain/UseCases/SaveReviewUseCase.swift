import Foundation

protocol SaveReviewUseCaseProtocol {
    func execute(review: Review, for id: String)
}

final class SaveReviewUseCase: SaveReviewUseCaseProtocol {
    // MARK: Dependencies

    private let saveReviewService: SaveReviewServiceProtocol

    // MARK: - Initialization

    init(saveReviewService: SaveReviewServiceProtocol) {
        self.saveReviewService = saveReviewService
    }

    // MARK: - Execute use case

    func execute(review: Review, for id: String) {
        let dto = ReviewDTO(restaurantName: review.restaurantName,
                            restaurantAddress: review.restaurantAddress,
                            lightRate: Float(review.lightRate),
                            waitRate: Float(review.waitRate),
                            soundRate: Float(review.soundRate),
                            userPhotos: review.userPhotos.compactMap { $0.compressedJPEG() },
                            userTags: review.userTags,
                            restaurantRate: review.restaurantRate)

        saveReviewService.saveReview(dto, for: id)
    }
}
