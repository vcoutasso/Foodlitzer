import SwiftUI

struct UserReviewGalleryInputBlock: View {
    // MARK: - Attributes

    private static let imagePlaceholder = UIImage(systemName: "photo")!

    @State private var isShowingPhotoPicker = false
    @State private var images = [imagePlaceholder]
    @State private var videos = [URL]()
    @Binding var content: [UIImage]

    var body: some View {
        VStack {
            if content.isEmpty {
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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)

                        ForEach(content, id: \.self) { media in

                            Button {
                                // TODO: esse botao do inferno se recusa mudar hit box, nesse momento esta inteiro clicavel para remover
                                withAnimation {
                                    if let index = content.firstIndex(of: media) {
                                        content.remove(at: index)
                                    }
                                }
                            } label: {
                                ZStack {
                                    Image(uiImage: media)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 135)
                                        .border(Color.black, width: 0.3)
                                        .clipped()

                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.black)
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .background(Circle().foregroundColor(Color.white).padding(2))
                                        .offset(x: 32, y: -51)
                                }
                            }
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
