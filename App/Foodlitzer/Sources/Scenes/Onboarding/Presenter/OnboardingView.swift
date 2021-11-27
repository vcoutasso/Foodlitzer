import SwiftUI

struct OnboardingView<ViewModelType>: View where ViewModelType: OnboardingViewModelProtocol {
    // MARK: - Attributes

    @ObservedObject private(set) var viewModel: ViewModelType

    private let onboardingPages = Array(1...3)

    // MARK: - View body

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(onboardingPages, id: \.self) { index in
                    LogoOnboardingView(currentPage: index)
                        .clipped()
                        .ignoresSafeArea()
                        .tag(index)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            OnboardingBottomView(pageNumber: viewModel.currentPage)
        }.background(Assets.Colors.backgroundGray.color)
    }
}

#if DEBUG
    struct OnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
#endif
