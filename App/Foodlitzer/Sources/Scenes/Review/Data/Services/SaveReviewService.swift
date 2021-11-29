import Foundation

protocol SaveReviewServiceProtocol {
    func saveReview(_ review: RestaurantReviewDTO, for id: String)
}

final class SaveReviewService: SaveReviewServiceProtocol {
    // MARK: - Dependencies

    private let reviewsDatabaseService: FirebaseDatabaseService<RestaurantReviewDTO>

    // MARK: - Initialization

    init(reviewsDatabaseService: FirebaseDatabaseService<RestaurantReviewDTO>) {
        self.reviewsDatabaseService = reviewsDatabaseService
    }

    // MARK: - Save review

    func saveReview(_ review: RestaurantReviewDTO, for id: String) {
        let path = "restaurants/\(id)/reviews"

        reviewsDatabaseService.addDocument(review, to: path)
    }
}
