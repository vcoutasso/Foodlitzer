import SwiftUI

struct RestaurantModel {
    var name: String
    var address: String
    var id: String

    init() {
        self.name = ""
        self.id = ""
        self.address = ""
    }

    init(name: String, address: String, id: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}

struct NewReviewView<ViewModelType>: View where ViewModelType: NewReviewViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelType
    @Environment(\.dismiss) var dismiss
    @Namespace var tagPosition
    @State var isTyping: Bool = false
    @State var query = ""
    @State var currentTag = ""
    @State var restaurant: RestaurantModel

    // passar id -> dimiss

    var body: some View {
        ScrollView {
            ScrollViewReader { _ in
                VStack(alignment: .leading, spacing: 40) {
                    HStack {
                        Spacer()

                        Text(Localizable.NewReview.Title.text)
                            .font(.lora(.regular, size: 36))

                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 15)

                    if restaurant.id.isEmpty {
                        RestaurantsSearchBlock(query: $viewModel.query, selectedRestaurant: $restaurant)
                    } else {
                        VStack(alignment: .center) {
                            Text(restaurant.name)
                                .font(.sfCompactText(.regular, size: 24))
                                .padding(.bottom, 10)

                            Text(restaurant.address)
                                .font(.sfCompactText(.light, size: 12))
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                        Button {
                            restaurant = .init()
                        } label: {
                            VStack(alignment: .center) {
                                HStack {
                                    Spacer()
                                    Image(systemName: Strings.Symbols.search)
                                        .font(.system(size: 12))
                                    Text(Localizable.Search.Placeholder.text)
                                        .font(.sfCompactText(.regular, size: 10))
                                    Spacer()
                                }
                                .foregroundColor(.black)
                            }
                            .padding(.horizontal, 40)
                        }
                    }

                    ItemEvaluation(item: $viewModel.ambientLighting, isEditing: viewModel.canSliderMove,
                                   restaurantFeatures: lightEvatuation)
                        .padding(.horizontal, 40)

                    ItemEvaluation(item: $viewModel.waitingTime, isEditing: viewModel.canSliderMove,
                                   restaurantFeatures: waitEvaluation)
                        .padding(.horizontal, 40)

                    // MARK: - Avaliação sonora

                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: Strings.Symbols.waveform)
                                .padding(4)
                                .background(Circle()
                                    .strokeBorder(Color.black, lineWidth: 0.3)
                                    .foregroundColor(.white))
                                .foregroundColor(.black)

                            Text(Localizable.NewReview.Sound.text)
                                .font(.sfCompactText(.regular, size: 14))
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)

                        HStack(spacing: 2.8) {
                            Spacer()

                            ForEach(viewModel.readingsInfo, id: \.self) { reading in
                                soundBar(for: reading.level)
                            }

                            Spacer()
                        }

                        Button {
                            viewModel.recordAudio()
                        } label: {
                            Text(Localizable.NewReview.SoundButton.text)
                                .font(.sfCompactText(.regular, size: 14))
                                .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                                .foregroundColor(!viewModel.isRecordingButtonActive ? .black.opacity(0.3) : .white)
                                .background(!viewModel.isRecordingButtonActive ? Color.white : Color.black)
                                .animation(.default, value: viewModel.isRecordingButtonActive)
                        }
                        .buttonDisableAnimation(state: !viewModel.isRecordingButtonActive)
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

                    UserRatingBlock(userRate: $viewModel.userRating)
                        .padding(.horizontal, 40)

                    Button {
                        viewModel.sendReview(for: restaurant.id)
                        dismiss()
                    } label: {
                        Text(Localizable.NewReview.Next.text)
                            .font(.sfCompactText(.regular, size: 14))
                            .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                            .foregroundColor(restaurant.id.isEmpty ? .black.opacity(0.3) : .white)
                            .background(restaurant.id.isEmpty ? Color.white : Color.black)
                            .animation(.default, value: restaurant.id.isEmpty)
                    }
                    .buttonDisableAnimation(state: restaurant.id.isEmpty)
                    .padding(.horizontal, 40)
                }
            }
        }
        .background(Color(Assets.Colors.backgroundGray)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all))
    }

    // MARK: - Views

    private func soundBar(for level: Float) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(Assets.Colors.foodlitzerBlack))
                .frame(width: 1.8, height: CGFloat(level))
        }
    }

    // MARK: - Helper methods

    private func getValue(_ value: CGFloat) -> String {
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

let lightEvatuation = FeatureDefinition(question: Localizable.NewReview.Light.text, symbol: Strings.Symbols.light,
                                        rate: [
                                            Localizable.NewReview.Lowlight.text,
                                            Localizable.NewReview.Highlight.text,
                                        ])

let waitEvaluation = FeatureDefinition(question: Localizable.NewReview.Time.text, symbol: Strings.Symbols.clock,
                                       rate: [Localizable.NewReview.Fast.text, Localizable.NewReview.Slow.text])
