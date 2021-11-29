import Foundation

protocol FetchReviewsServiceProtocol {
    func fetchReviews(for id: String) async -> [RestaurantReviewDTO]
    func reviewCount(for id: String) async -> Int?
}

final class FetchReviewsService: FetchReviewsServiceProtocol {
    // MARK: - Dependencies

    private let databaseReviewsService: FirebaseDatabaseService<RestaurantReviewDTO>

    // MARK: - Initialization

    init(databaseReviewsService: FirebaseDatabaseService<RestaurantReviewDTO>) {
        self.databaseReviewsService = databaseReviewsService
    }

    // MARK: - Fetch reviews

    func fetchReviews(for id: String) async -> [RestaurantReviewDTO] {
        await databaseReviewsService.fetchCollection(from: "restaurants/\(id)/reviews")
    }

    func reviewCount(for id: String) async -> Int? {
        await databaseReviewsService.documentCount(from: id)
    }
}
