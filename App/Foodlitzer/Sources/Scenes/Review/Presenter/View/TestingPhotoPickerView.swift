import PhotosUI
import SwiftUI

struct TestingPhotoPickerView: View {
    // MARK: - Attributes

    @State private var isShowingPhotoPicker = false
    @State private var images = [imagePlaceholder]
    @State private var videos = [URL]()

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
                                     selectedVideos: $videos,
                                     isPresented: $isShowingPhotoPicker)
        }
    }
}

extension TestingPhotoPickerView {
    enum PickerConfigurationFactory {
        static func make() -> PHPickerConfiguration {
            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            configuration.filter = .any(of: [.images, .videos])
            configuration.selectionLimit = 0
            return configuration
        }
    }
}
