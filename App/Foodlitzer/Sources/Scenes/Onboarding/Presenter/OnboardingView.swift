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
                TemplateOnboardingPageView(image: Image(Assets.Images.onboardingPage3),
                                           text: Localizable.OnBoarding.PageTwo.text)
                    .tag(3)
                TemplateOnboardingPageView(image: Image(Assets.Images.onboardingPage4),
                                           text: Localizable.OnBoarding.PageThree.text)
                    .tag(4)
            }
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            OnboardingBottomView(pageNumber: viewModel.currentPage)
        }.background(Color(Assets.Colors.backgroundGray))
    }
}

#if DEBUG
    struct OnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
#endif
