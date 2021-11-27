import SwiftUI

struct OnboardingView<ViewModelType>: View where ViewModelType: OnboardingViewModelProtocol {
    // MARK: - Attributes

    @ObservedObject private(set) var viewModel: ViewModelType

    private let onboardingPages = Array(1...3)

    // MARK: - View body

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                LogoOnboardingView()
                    .tag(1)
                SecondPageOnboardingView()
                    .tag(2)
                TemplateOnboardingPageView(image: "onboarding3", text: "Review the places you've been to")
                    .tag(3)
                TemplateOnboardingPageView(image: "onboarding4", text: "And find great new restaurants to experience!")
                    .tag(4)
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
