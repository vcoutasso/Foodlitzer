//
//  PhotoPickerRepresentable+.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 10/11/21.
//

import UIKit

extension PhotoPickerRepresentable.Coordinator: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Delegate methods

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        photoPicker.selectedImage = image
        picker.dismiss(animated: true)
    }
}
