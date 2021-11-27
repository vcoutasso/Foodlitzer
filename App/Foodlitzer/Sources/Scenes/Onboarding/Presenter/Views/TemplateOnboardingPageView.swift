//
//  TemplateOnboardingPageView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 27/11/21.
//

import SwiftUI

struct TemplateOnboardingPageView: View {
    var image: String
    var text: String
    var body: some View {
        VStack {
            Text(text)
                .font(.custom("Lora-Regular", size: 34))
                .frame(width: 284, height: 139, alignment: .center)
                .multilineTextAlignment(.center)

            Image(image)
        }
    }
}
