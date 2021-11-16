//
//  OnboardingPageView.swift
//  SpiderVerse
//
//  Created by Vinícius Couto on 16/11/21.
//

import SwiftUI

struct OnboardingPageView: View {
    let pageNumber: Int

    var body: some View {
        Text("Onboarding page \(pageNumber)")
    }
}

#if DEBUG
    struct OnboardingPageView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingPageView(pageNumber: 0)
        }
    }
#endif
