//
//  InformationView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InformationView: View {
    // MARK: Atributos

    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var image: Image
    var address: String
    var price: Int
    var body: some View {
        ZStack {
            PlayerView()
                .ignoresSafeArea()
            TabView {
                InfoPageOneView(restaurantName: restaurantName,
                                restaurantRate: restaurantRate,
                                isReviewed: isReviewed,
                                image: image,
                                address: address,
                                price: price)
                InfoPageTwoView()
                InfoPageThreeView()
                    .ignoresSafeArea()
                InfoPageFourView()
            }
            TopInfoView(restaurantName: restaurantName)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}
