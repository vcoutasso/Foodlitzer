import Foundation

// FIXME: - Not part of review scene
protocol FetchReviewsServiceProtocol {
    func fetchReviews(for id: String) async -> [ReviewDTO]
}

final class FetchReviewsService: FetchReviewsServiceProtocol {
    // MARK: - Dependencies

    private let databaseReviewsService: FirebaseDatabaseService<ReviewDTO>

    // MARK: - Initialization

    init(databaseReviewsService: FirebaseDatabaseService<ReviewDTO>) {
        self.databaseReviewsService = databaseReviewsService
    }

    // MARK: - Fetch reviews

    func fetchReviews(for id: String) async -> [ReviewDTO] {
        let reviews = await databaseReviewsService.fetchCollection(from: "restaurants/\(id)/reviews")

        return reviews
    }
}
