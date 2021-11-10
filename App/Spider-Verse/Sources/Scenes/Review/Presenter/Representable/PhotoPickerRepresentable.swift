//
//  PhotoPickerRepresentable.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 10/11/21.
//

import SwiftUI

struct PhotoPickerRepresentable: UIViewControllerRepresentable {
    // MARK: - Attributes

    @Binding var selectedImage: UIImage

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator

        return picker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(photoPicker: self)
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // MARK: - Inner types

    final class Coordinator: NSObject {
        // MARK: - Attributes

        let photoPicker: PhotoPickerRepresentable

        // MARK: - Object lifecycle

        init(photoPicker: PhotoPickerRepresentable) {
            self.photoPicker = photoPicker
        }
    }
}
