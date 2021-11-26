import Foundation

protocol SaveMediaUseCaseProtocol {
    func execute(images: [RestaurantImageDTO], videos: [RestaurantVideoDTO], for id: String)
}

final class SaveMediaUseCase: SaveMediaUseCaseProtocol {
    // MARK: - Dependencies

    private let imageDatabaseService: FirebaseDatabaseService<RestaurantImageDTO>
    private let videoDatabaseService: FirebaseDatabaseService<RestaurantVideoDTO>

    // MARK: - Initialization

    init(imageDatabaseService: FirebaseDatabaseService<RestaurantImageDTO>,
         videoDatabaseService: FirebaseDatabaseService<RestaurantVideoDTO>) {
        self.imageDatabaseService = imageDatabaseService
        self.videoDatabaseService = videoDatabaseService
    }

    // MARK: - Execute use case

    func execute(images: [RestaurantImageDTO], videos: [RestaurantVideoDTO], for id: String) {
        uploadImages(imageDTOs: images, for: id)
        uploadVideos(videoDTOs: videos, for: id)
    }

    private func uploadImages(imageDTOs: [RestaurantImageDTO], for id: String) {
        let path = "restaurants/\(id)/images"

        let group = DispatchGroup()

        imageDTOs.forEach {
            group.enter()
            imageDatabaseService.addDocument($0, to: path)
            group.leave()
        }
    }

    private func uploadVideos(videoDTOs: [RestaurantVideoDTO], for id: String) {
        let path = "restaurants/\(id)/videos"

        let group = DispatchGroup()

        // FIXME: Doesn't seem to work for large files (11MB was too big)
        videoDTOs.forEach {
            group.enter()
            videoDatabaseService.addDocument($0, to: path)
            group.leave()
        }
    }
}
