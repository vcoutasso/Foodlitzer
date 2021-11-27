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
        Text("Get valuable information about restaurants near you")
            .font(.custom("Lora-Regular", size: 34))
            .frame(width: 338, height: 139, alignment: .center)
            .multilineTextAlignment(.center)
    }

    private var light: some View {
        HStack(alignment: .center) {
            Image(systemName: "lightbulb")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text("Light")
                .font(.compact(.light, size: 12))
                .foregroundColor(.white)
                .background(Rectangle().fill(.black)
                    .frame(width: 53, height: 23))
        }.padding(.vertical, 30)
    }

    private var waitingTime: some View {
        HStack(alignment: .center) {
            Image(systemName: "clock")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text("Waiting Time")
                .font(.compact(.light, size: 12))
                .foregroundColor(.white)
                .background(Rectangle().fill(.black)
                    .frame(width: 97, height: 23))
        }.padding(.vertical, 30)
    }

    private var backgroundNoise: some View {
        HStack(alignment: .center) {
            Image(systemName: "waveform")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(Color("onboardingGray"))
                .frame(width: 30, height: 42)
                .padding(.trailing, 20)
            Text("Background Noise")
                .font(.compact(.light, size: 12))
                .foregroundColor(.white)
                .background(Rectangle().fill(.black)
                    .frame(width: 128, height: 23))
        }.padding(.vertical, 30)
    }
}

struct SecondPageOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPageOnboardingView()
    }
}
