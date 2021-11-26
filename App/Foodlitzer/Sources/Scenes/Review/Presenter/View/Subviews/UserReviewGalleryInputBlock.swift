import SwiftUI
import UIKit

struct UserReviewGalleryInputBlock: View {
    // MARK: - Attributes

    private static let imagePlaceholder = UIImage(systemName: "photo")!

    @State private var isShowingPhotoPicker = false
    @Binding var images: [UIImage]
    @Binding var videos: [Data]

    var body: some View {
        VStack {
            if images.isEmpty {
                HStack {
                    Image(uiImage: images.first ?? UserReviewGalleryInputBlock.imagePlaceholder)
                        .font(.system(size: 42, weight: .light, design: .default))
                        .foregroundColor(Color.black.opacity(0.3))
                        .frame(width: UIScreen.main.bounds.width - 80, height: 150, alignment: .center)
                        .background(Color.black.opacity(0.1))
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 40)

            } else {
                // FIXME: Show preview of videos as well
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)

                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 135)
                                .border(Color.black, width: 0.3)
                                .clipped()
                        }
                        .padding(.trailing, 15)

                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.bottom, 10)
            }

            DefaultButton(label: "Selecionar de vídeos e imagens") {
                isShowingPhotoPicker.toggle()
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPickerRepresentable(pickerConfiguration: PickerConfigurationFactory.make(),
                                     selectedImages: $images,
                                     selectedVideos: $videos,
                                     isPresented: $isShowingPhotoPicker)
        }
    }
}
