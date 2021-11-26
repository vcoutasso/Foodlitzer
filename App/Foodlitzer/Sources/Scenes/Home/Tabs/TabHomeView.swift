//
//  TabHomeView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 24/11/21.
//

import SwiftUI

// MARK: - Inner types

struct TabHomeView: View {
    // MARK: - Properties

    @MainActor var viewModel: TabHomeViewModel
    @State private(set) var restaurants: [Model] = []

    var body: some View {
        VStack {
            helloName
            Spacer()
            description
            Spacer()
            bestReviewed
            placesToDiscover
            Button {
                DispatchQueue.main.async {
                    viewModel.handleButtonTapped { restaurants in
                        self.restaurants = restaurants
                    }
                }
            } label: {
                Text("hello")
            }
            ForEach(restaurants) { place in
                Text(place.name)
                Text(place.address)
                place.images[0]
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
            }

        }.onAppear {
            viewModel.handleOnAppear()
        }
    }

    struct Model: Identifiable {
        let id: String
        let name: String
        let address: String
        let images: [Image]
    }

    private var helloName: some View {
        Text("Hi, Fulano")
            .font(.custom("Lora-Regular", size: 24))
    }

    private var description: some View {
        VStack(alignment: .center) {
            VStack {
                Text("Getting to know a restaurant is key to having a good dining experience. But you already knew that! Wanna tell us about an experience you've had!")
                    .font(.compact(.light, size: 14))
                    .lineSpacing(10)
                    .frame(width: 291, height: 98, alignment: .center)
                    .multilineTextAlignment(.center)
            }.background(Rectangle()
                .strokeBorder(lineWidth: 0.5)
                .frame(width: 330, height: 149))
            HStack {
                Image(systemName: "newspaper")
                Text("New review")
                    .font(.compact(.regular, size: 12))
                    .foregroundColor(Color.white)
                    .background(Rectangle()
                        .frame(width: 195, height: 31, alignment: .center)
                        .background(Color.black))

            }.zIndex(10)
                .offset(x: -18, y: 5)
        }
    }

    private var bestReviewed: some View {
        VStack {
            Text("Best Reviewed")
                .font(.custom("Lora-Regular", size: 24))
            Text("Check out these reviews about restaurants you don't know yet!")
                .font(.compact(.light, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("textGray"))
                .frame(width: 313, height: 40, alignment: .center)
                .padding(.top, 5)
        }
    }

    private var placesToDiscover: some View {
        VStack {
            Text("Places to Discover")
                .font(.custom("Lora-Regular", size: 24))
            Text("Here are the latest restaurants you've reviewed.")
                .font(.compact(.light, size: 14))
                .foregroundColor(Color("textGray"))
                .padding(.top, 5)
        }
    }
}
