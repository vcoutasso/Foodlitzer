import SwiftUI

struct NewReview<ViewModelType>: View where ViewModelType: NewReviewViewModelProtocol {
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
                            .font(.system(size: 36, weight: .regular, design: .serif))

                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 15)

                    RestaurantsSearchBlock(query: $viewModel.query)

                    ItemEvaluation(item: $viewModel.lightRate, isEditing: viewModel.canSliderMove,
                                   restaurantFeatures: lightEvatuation)
                        .padding(.horizontal, 40)

                    ItemEvaluation(item: $viewModel.waitRate, isEditing: viewModel.canSliderMove,
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
                                .font(.system(size: 14, weight: .regular, design: .default))
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)

                        DefaultButton(label: "Avaliar Agora") {
                            // Sound wave action here
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

                    UserReviewGalleryInputBlock(content: $viewModel.userPhotos)

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

                    UserRatingBlock(userRate: $viewModel.restaurantRate)
                        .padding(.horizontal, 40)

                    Button {
                        // action here
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
