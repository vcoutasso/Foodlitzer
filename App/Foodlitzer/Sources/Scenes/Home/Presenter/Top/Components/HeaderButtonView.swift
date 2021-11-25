//
//  HeaderButtonView.swift
//  SpiderVerse
//
//  Created by Alessandra Souza da Silva on 23/11/21.
//

import SwiftUI

struct HeaderButtonView<Destination: View>: View {
    var text: String
    var destination: () -> Destination

    init(text: String, destination: @escaping () -> Destination) {
        self.text = text
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Image(systemName: text)
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color("iconsHeaderGray"))
            .padding()
        }
    }
}

struct HeaderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButtonView(text: "gear") {
            EmptyView()
        }
    }
}
