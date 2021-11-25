import PhotosUI
import SwiftUI
import UIKit

protocol MultiplePhotoPicker {
    var selectedImages: [UIImage] { get }
    var selectedVideos: [URL] { get }
    var isPresented: Bool { get }

    func clearSelection()
    func handle(error: Error?)
    func selectPhoto(_ image: UIImage)
    func selectVideo(_ url: URL)
    func dismiss()
}

struct PhotoPickerRepresentable: MultiplePhotoPicker, UIViewControllerRepresentable {
    // MARK: - Dependencies

    let pickerConfiguration: PHPickerConfiguration

    // MARK: - Attributes

    @Binding var selectedImages: [UIImage]
    @Binding var selectedVideos: [URL]
    @Binding var isPresented: Bool

    // MARK: - Representable methods

    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: pickerConfiguration)
        picker.delegate = context.coordinator

        return picker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(photoPicker: self)
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Not needed
    }

    // MARK: - Picker methods

    func clearSelection() {
        selectedImages.removeAll()
        selectedVideos.removeAll()
    }

    func handle(error: Error?) {
        debugPrint("Could not load image. Got error: '\(String(describing: error?.localizedDescription))'")
    }

    func selectPhoto(_ image: UIImage) {
        selectedImages.append(image)
    }

    func selectVideo(_ url: URL) {
        selectedVideos.append(url)
    }

    func dismiss() {
        isPresented = false
    }

    // MARK: - Inner types

    final class Coordinator: NSObject {
        // MARK: - Attributes

        private let photoPicker: MultiplePhotoPicker

        // MARK: - Identifiers

        private let movieIdentifier = UTType.movie.identifier

        // MARK: - Object lifecycle

        init(photoPicker: PhotoPickerRepresentable) {
            self.photoPicker = photoPicker
        }
    }
}

// MARK: - Inner types

extension PhotoPickerRepresentable.Coordinator {
    // MARK: - Type aliases

    private typealias ImageType = UIImage
}

// MARK: - Delegate methods

extension PhotoPickerRepresentable.Coordinator: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        photoPicker.clearSelection()
        parseAndUpdatePickingResults(results)
        photoPicker.dismiss()
    }

    // MARK: - Helper methods

    private func parseAndUpdatePickingResults(_ results: [PHPickerResult]) {
        let imageLoader: (PHPickerResult) -> Void = { [loadImageCompletionHandler] in
            $0.itemProvider.loadObject(ofClass: ImageType.self, completionHandler: loadImageCompletionHandler)
        }

        let videoLoader: (PHPickerResult) -> Void = { [loadVideoCompletionHandler, movieIdentifier] in
            $0.itemProvider.loadFileRepresentation(forTypeIdentifier: movieIdentifier,
                                                   completionHandler: loadVideoCompletionHandler)
        }

        results.filter { $0.itemProvider.canLoadObject(ofClass: ImageType.self) }
            .forEach(imageLoader)

        results.filter { $0.itemProvider.hasItemConformingToTypeIdentifier(movieIdentifier) }
            .forEach(videoLoader)
    }

    private func loadImageCompletionHandler(reading: NSItemProviderReading?, error: Error?) {
        guard let image = reading as? ImageType else {
            photoPicker.handle(error: error)
            return
        }

        photoPicker.selectPhoto(image)
    }

    private func loadVideoCompletionHandler(url: URL?, error: Error?) {
        guard let url = url else {
            photoPicker.handle(error: error)
            return
        }

        photoPicker.selectVideo(url)
    }
}

enum PickerConfigurationFactory {
    static func make() -> PHPickerConfiguration {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .any(of: [.images, .videos])
        configuration.selectionLimit = 0
        return configuration
    }
}
