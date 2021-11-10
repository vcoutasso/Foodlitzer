//
//  PhotoPickerRepresentable.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 10/11/21.
//

import PhotosUI
import SwiftUI
import UIKit

protocol MultiplePhotoPicker {
    var selectedImages: [UIImage] { get }
    var isPresented: Bool { get }

    func clearSelection()
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

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    // MARK: - Picker methods

    func clearSelection() {
        selectedImages.removeAll()
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

        let photoPicker: MultiplePhotoPicker

        // MARK: - Object lifecycle

        init(photoPicker: PhotoPickerRepresentable) {
            self.photoPicker = photoPicker
        }
    }
}

extension PhotoPickerRepresentable.Coordinator: PHPickerViewControllerDelegate {
    // MARK: - Type aliases

    private typealias ResultType = UIImage

    // MARK: - Delegate methods

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        photoPicker.clearSelection()
        parseAndUpdatePickingResults(results)
        photoPicker.dismiss()
    }

    // MARK: - Helper methods

    private func parseAndUpdatePickingResults(_ results: [PHPickerResult]) {
        results.filter { $0.itemProvider.canLoadObject(ofClass: ResultType.self) }
            .forEach {
                $0.itemProvider.loadObject(ofClass: ResultType.self,
                                           completionHandler: loadImageCompletionHandler(image:error:))
            }
    }

    private func loadImageCompletionHandler(image: NSItemProviderReading?, error: Error?) {
        if let image = image as? UIImage {
            photoPicker.selectPhoto(image)
        } else if let error = error {
            print("Could not load image. Got error: '\(error.localizedDescription)'")
        }
    }
}
