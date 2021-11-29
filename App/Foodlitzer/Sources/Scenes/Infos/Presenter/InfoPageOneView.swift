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
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Spacer()

                HStack {
                    Spacer()
                    Image(systemName: Strings.Symbols.address)
                        .font(.system(size: 11))

                    Text(address)
                        .font(.sfCompactText(.light, size: 11))
                    Spacer()
                }
                .padding(.vertical, 5)

                HStack {
                    HStack {
                        Spacer()
                        Image(Assets.Images.googleIcon)
                            .padding(.horizontal, 7)

                        ForEach(1..<5) { _ in
                            Image(systemName: "star")
                                .font(.system(size: 11))
                        }
                        Spacer()
                    }
                    Spacer()
                    Rectangle()
                        .frame(width: 0.4)
                    Spacer()

                    HStack {
                        Spacer()
                        Image(systemName: "dollarsign.circle")

                        ForEach(0..<price) { _ in
                            Text("$")
                                .font(.sfCompactText(.light, size: 11))
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 5)
                .background(Color.white.border(Color.black, width: 0.3))

                HStack {
                    Spacer()
                    ForEach(1..<5) { _ in
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.system(size: 11))
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            .background(Color.white.border(Color.black, width: 0.3))
            .frame(height: 90)
            .padding(40)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 115, alignment: .bottom)
    }
}
