//
//  OnboardingView.swift
//  SpiderVerse
//
//  Created by Vinícius Couto on 16/11/21.
//

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
                ForEach(onboardingPages, id: \.self) { index in
                    LogoOnboardingView(currentPage: index)
                        .clipped()
                        .ignoresSafeArea()
                        .tag(index)
                }
            }.edgesIgnoringSafeArea(.top)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            OnboardingPageView(pageNumber: viewModel.currentPage)

        }.background(Color.white)
    }
}

#if DEBUG
    struct OnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
#endif
