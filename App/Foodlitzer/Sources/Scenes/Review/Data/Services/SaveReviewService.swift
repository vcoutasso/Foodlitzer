import Foundation

protocol SaveReviewServiceProtocol {
    func saveReview(_ review: ReviewDTO, for id: String)
}

final class SaveReviewService: SaveReviewServiceProtocol {
    // MARK: - Dependencies

    private let reviewsDatabaseService: FirebaseDatabaseService<ReviewDTO>

    // MARK: - Initialization

    init(reviewsDatabaseService: FirebaseDatabaseService<ReviewDTO>) {
        self.reviewsDatabaseService = reviewsDatabaseService
    }

    // MARK: - Save review

    func saveReview(_ review: ReviewDTO, for id: String) {
        let path = "restaurants/\(id)/reviews"

        reviewsDatabaseService.addDocument(review, to: path)
    }
}
