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
        let dto = ReviewDTO(restaurantID: id,
                            ambientLighting: Float(review.ambientLighting),
                            waitingTime: Float(review.waitingTime),
                            ambientNoise: Float(review.ambientNoise),
                            userTags: review.userTags,
                            userRating: review.userRating)

        saveReviewService.saveReview(dto, for: id)
    }
}
