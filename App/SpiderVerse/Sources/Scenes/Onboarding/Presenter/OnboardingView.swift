import SwiftUI

struct OnboardingView<ViewModelType>: View where ViewModelType: OnboardingViewModelProtocol {
    // MARK: - Attributes

    @ObservedObject private(set) var viewModel: ViewModelType
    // TODO: Show actual page content
    private let onboardingPages = Array(1...3)

    // MARK: - View body

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(onboardingPages, id: \.self) {
                    OnboardingPageView(pageNumber: $0)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        }
    }
}

#if DEBUG
    struct OnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
#endif
