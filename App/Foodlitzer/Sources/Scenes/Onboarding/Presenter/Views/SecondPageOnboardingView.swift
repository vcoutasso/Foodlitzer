//
//  SecondPageOnboardingView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 27/11/21.
//

import SwiftUI

struct SecondPageOnboardingView: View {
    var body: some View {
        VStack(alignment: .center) {
            title
            VStack(alignment: .leading) {
                light
                waitingTime
                backgroundNoise

            }
        }
    }

    private var title: some View {
        Text(Localizable.OnBoarding.PageOne.text)
            .font(.custom("Lora-Regular", size: 34))
            .multilineTextAlignment(.center)
            .lineSpacing(15)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var light: some View {
        HStack(alignment: .center) {
            Image(systemName: "lightbulb")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text(Localizable.OnBoarding.Light.text)
                .font(.sfCompactText(.light, size: 12))
                .foregroundColor(.white)
                .frame(width: 128, height: 23)
                .background(Rectangle().fill(.black))
        }.padding(.vertical, 30)
    }

    private var waitingTime: some View {
        HStack(alignment: .center) {
            Image(systemName: "clock")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text(Localizable.OnBoarding.WaitingTime.text)
                .font(.sfCompactText(.light, size: 12))
                .foregroundColor(.white)
                .frame(width: 128, height: 23)
                .background(Rectangle().fill(.black))
        }.padding(.vertical, 30)
    }

    private var backgroundNoise: some View {
        HStack(alignment: .center) {
            Image(systemName: "waveform")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text(Localizable.OnBoarding.Noise.text)
                .font(.sfCompactText(.light, size: 12))
                .foregroundColor(.white)
                .frame(width: 128, height: 23)
                .background(Rectangle().fill(.black))
        }.padding(.vertical, 30)
            .padding(.bottom, 70)
    }
}

#if DEBUG
    struct SecondPageOnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            SecondPageOnboardingView()
        }
    }
#endif
