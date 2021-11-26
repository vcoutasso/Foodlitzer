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

    @MainActor var viewModel: TabRestaurantViewModel
//    @State private(set) var restaurants: [Model] = []

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.background(Color.red)
//        ScrollView {
//            VStack {
//                Button {
//                    DispatchQueue.main.async {
//                        viewModel.handleButtonTapped { restaurants in
//                            self.restaurants = restaurants
//                        }
//                    }
//                } label: {
//                    Text("hello")
//                }
//                ForEach(restaurants) { place in
//                    Text(place.name)
//                    Text(place.address)
//                    place.images[0]
//                        .resizable()
//                        .frame(width: 120, height: 120, alignment: .center)
//                }
//
//            }.onAppear {
//                viewModel.handleOnAppear()
//            }
//        }
//
    }
}

struct TabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeView(viewModel: TabHomeViewModelFactory.make())
    }
}
