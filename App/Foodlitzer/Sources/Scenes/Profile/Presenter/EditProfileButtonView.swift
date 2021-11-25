//
//  EditProfileButtonView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 25/11/21.
//

import SwiftUI

struct EditProfileButtonView<Destination: View>: View {
    var destination: () -> Destination

    init(destination: @escaping () -> Destination) {
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color("iconsHeaderGray"))
            .padding()
        }
    }
}
