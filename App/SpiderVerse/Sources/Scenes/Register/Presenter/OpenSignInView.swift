//
//  OpenSignInView.swift
//  SpiderVerse
//
//  Created by Alessandra Souza da Silva on 22/11/21.
//

import SwiftUI

struct OpenSignInView<Destination: View>: View {
    var destination: () -> Destination
    init(destination: @escaping () -> Destination) {
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Text("Sign In")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}

struct OpenSignInView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSignInView {
            EmptyView()
        }
    }
}
