//
//  TestingPhotoPickerView.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 10/11/21.
//

import PhotosUI
import SwiftUI

struct TestingPhotoPickerView: View {
    // MARK: - Attributes

    @State private var isShowingPhotoPicker = false
    @State private var images = [imagePlaceholder]

    private static let imagePlaceholder = UIImage(systemName: "person.fill")!

    // MARK: - View

    var body: some View {
        VStack {
            Image(uiImage: images.first ?? TestingPhotoPickerView.imagePlaceholder)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
                .padding()
                .onTapGesture { isShowingPhotoPicker.toggle() }

            Spacer()
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPickerRepresentable(pickerConfiguration: PickerConfigurationFactory.make(),
                                     selectedImages: $images,
                                     isPresented: $isShowingPhotoPicker)
        }
    }
}

extension TestingPhotoPickerView {
    enum PickerConfigurationFactory {
        static func make() -> PHPickerConfiguration {
            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            configuration.filter = .images
            configuration.selectionLimit = 0
            return configuration
        }
    }
}
