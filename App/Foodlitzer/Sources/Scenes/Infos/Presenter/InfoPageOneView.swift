//
//  InfoPageOneView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageOneView: View {
    var restaurantName: String
    var restaurantRate: Int
    var isReviewed: Bool
    var image: Image
    var address: String
    var price: Int
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    Image(systemName: Strings.Symbols.address)
                        .padding(.leading, 10)
                        .font(.system(size: 12, weight: .light, design: .default))
                    Text(address)
                        .font(.sfCompactText(.light, size: 11))
                        .padding(5)
                }.background(Rectangle().foregroundColor(.white).border(Color.black, width: 0.3).frame(height: 33))
                    .padding(.bottom, 15)

                HStack(spacing: 20) {
                    HStack(spacing: 0) {
                        Image(Assets.Images.googleIcon)
                            .padding(.horizontal, 7)
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                    }

                    .background(Rectangle().foregroundColor(.white).border(Color.black, width: 0.3).frame(height: 33))
                    .padding(.bottom, 15)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        ForEach(0..<price) { _ in
                            Text("$")
                                .font(.sfCompactText(.light, size: 11))
                        }
                    }

                    .background(Rectangle().foregroundColor(.white).border(Color.black, width: 0.3).frame(height: 33))
                    .padding(.bottom, 15)
                }
                HStack {
//                    Image(Assets.Images.foodlitzerSymbol)
//                        .frame(width: 10, height: 15)
//                        .padding(.horizontal, 7)
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup")
                }

                .background(Rectangle().foregroundColor(.white).border(Color.black, width: 0.3).frame(height: 33))
                .padding(.bottom, 15)
            }
            .padding(.vertical, 50)
        }
    }
}
