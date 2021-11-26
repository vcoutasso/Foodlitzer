import SwiftUI

struct NewReviewView<ViewModelType>: View where ViewModelType: NewReviewViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelType
    @Namespace var tagPosition
    @State var isTyping: Bool = false
    @State var query = ""
    @State var currentTag = ""

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                VStack(alignment: .leading, spacing: 40) {
                    HStack {
                        Spacer()

                        Text("New Review")
                            .font(.lora(.regular, size: 36))

                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 15)

                    RestaurantsSearchBlock(query: $viewModel.query)

                    ItemEvaluation(item: $viewModel.ambientLighting, isEditing: viewModel.canSliderMove,
                                   restaurantFeatures: lightEvatuation)
                        .padding(.horizontal, 40)

                    ItemEvaluation(item: $viewModel.waitingTime, isEditing: viewModel.canSliderMove,
                                   restaurantFeatures: waitEvaluation)
                        .padding(.horizontal, 40)

                    // MARK: - Avaliação sonora

                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "waveform")
                                .padding(4)
                                .background(Circle()
                                    .strokeBorder(Color.black, lineWidth: 0.3)
                                    .foregroundColor(.white))
                                .foregroundColor(.black)

                            Text("Avaliação sonora:")
                                .font(.compact(.regular, size: 14))
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)

                        DefaultButton(label: "Avaliar Agora") {
                            SoundBars()
                        }
                        .padding(.horizontal, 40)
                    }

                    HStack {
                        Spacer()
                        Rectangle()
                            .frame(width: 155, height: 0.5, alignment: .center)
                        Spacer()
                    }
                    .padding(.horizontal, 40)

                    // MARK: - Photo picker

                    UserReviewGalleryInputBlock(images: $viewModel.userPhotos, videos: $viewModel.userVideos)

                    // TODO: verificar como passa os dados

                    UserTagsInputBlock(currentTag: $viewModel.currentTag, tags: $viewModel.userTags,
                                       isShowingKeyboard: $isTyping)
                        .onChange(of: isTyping, perform: { _ in
                            if isTyping {
                                withAnimation(.linear(duration: 0.5)) {
                                    value.scrollTo(tagPosition)
                                }
                            }
                        })
                        .padding(.horizontal, 40)
                        .id(tagPosition)

                    UserRatingBlock(userRate: $viewModel.userRating)
                        .padding(.horizontal, 40)

                    Button {
                        viewModel.sendReview()
                    } label: {
                        Text("Próximo")
                            .font(.system(size: 14, weight: .regular, design: .serif))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                            .background(Color.black)
                    }
                    .padding(.horizontal, 40)
                }
            }
        }
    }

    func getValue(_ value: CGFloat) -> String {
        let percent = value / (UIScreen.main.bounds.width - 171) // main.bounds slider + raio do Circle

        return String(format: "%.2f", percent)
    }
}

// TODO: Clean this up

struct FeatureDefinition {
    var question: String
    var symbol: String
    var rate: [String]
}

let lightEvatuation = FeatureDefinition(question: "How do you rate the lighting in the place?", symbol: "lightbulb",
                                        rate: ["Pouco iluminado", "Muito iluminado"])

let waitEvaluation = FeatureDefinition(question: "Como você avalia o tempo de esperar pela comida?", symbol: "clock",
                                       rate: ["Muito rápido", "Muito demorado"])

// let soundEvaluation: FeatureDefinition = FeatureDefinition(question: "Avaliação sonora:", symbol: "waveform")