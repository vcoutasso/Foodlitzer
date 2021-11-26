import AVFoundation
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

        videoDTOs.forEach { dto in
            Task {
                group.enter()

                let exportSession = await compressVideo(url: dto.url)
                guard let exportSession = exportSession else {
                    debugPrint("Got nil export session. Aborting upload.")
                    return
                }

                if case .completed = exportSession.status {
                    guard let compressedData = try? Data(contentsOf: exportSession.outputURL!) else { return }

                    videoDatabaseService.addDocument(RestaurantVideoDTO(url: dto.url, videoData: compressedData),
                                                     to: path)
                } else {
                    debugPrint("Could not complete video file compression.")
                }

                group.leave()
            }
        }
    }

    private func compressVideo(url: URL) async -> AVAssetExportSession? {
        let urlAsset = AVURLAsset(url: url)
        // TODO: Apparently Firestore caps at 10MB files. Medium quality is not always enough
        guard let exportSession = AVAssetExportSession(asset: urlAsset,
                                                       presetName: AVAssetExportPresetMediumQuality) else { return nil }

        exportSession.outputURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        await exportSession.export()
        return exportSession
    }
}
