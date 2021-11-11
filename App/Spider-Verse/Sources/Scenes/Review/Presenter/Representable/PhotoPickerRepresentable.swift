import PhotosUI
import SwiftUI
import UIKit

protocol MultiplePhotoPicker {
    var selectedImages: [UIImage] { get }
    var isPresented: Bool { get }

    func clearSelection()
    func handle(error: Error?)
    func selectPhoto(_ image: UIImage)
    func dismiss()
}

struct PhotoPickerRepresentable: MultiplePhotoPicker, UIViewControllerRepresentable {
    // MARK: - Dependencies

    let pickerConfiguration: PHPickerConfiguration

    // MARK: - Attributes

    @Binding var selectedImages: [UIImage]
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
    }

    func handle(error: Error?) {
        debugPrint("Could not load image. Got error: '\(String(describing: error?.localizedDescription))'")
    }

    func selectPhoto(_ image: UIImage) {
        selectedImages.append(image)
    }

    func dismiss() {
        isPresented = false
    }

    // MARK: - Inner types

    final class Coordinator: NSObject {
        // MARK: - Attributes

        private let photoPicker: MultiplePhotoPicker

        // MARK: - Object lifecycle

        init(photoPicker: PhotoPickerRepresentable) {
            self.photoPicker = photoPicker
        }
    }
}

// MARK: - Inner types

extension PhotoPickerRepresentable.Coordinator {
    // MARK: - Type aliases

    private typealias ResultType = UIImage
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
        let loader: (PHPickerResult) -> Void = { [loadImageCompletionHandler] in
            $0.itemProvider.loadObject(ofClass: ResultType.self, completionHandler: loadImageCompletionHandler)
        }

        results.filter { $0.itemProvider.canLoadObject(ofClass: ResultType.self) }
            .forEach(loader)
    }

    private func loadImageCompletionHandler(image: NSItemProviderReading?, error: Error?) {
        guard let image = image as? UIImage else {
            photoPicker.handle(error: error)
            return
        }

        photoPicker.selectPhoto(image)
    }
}
