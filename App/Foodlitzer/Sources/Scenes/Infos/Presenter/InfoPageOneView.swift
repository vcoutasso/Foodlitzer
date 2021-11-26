//
//  InfoPageOneView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageOneView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Image("locationicon")
                        .resizable()
                        .frame(width: 10, height: 15)
                    Text("Avenida Getúlio Vargas, 3030")
                }
                .modifier(FontePadrao())
                .frame(width: 350, height: 30)

                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image("GoogleIcon")
                            .padding(.horizontal, 7)
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                    }
                    .modifier(FontePadrao())
                    .frame(width: 175, height: 30)

                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("$$$$")
                    }
                    .modifier(FontePadrao())
                    .frame(width: 175, height: 30)
                }
                HStack {
                    Image("FoodlitzerIcon")
                        .frame(width: 10, height: 15)
                        .padding(.horizontal, 7)
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup")
                }
                .modifier(FontePadrao())
                .frame(width: 175, height: 30)
            }
            .padding(.vertical, 50)
        }
    }
}

#if DEBUG
    struct InfoPageOneView_Previews: PreviewProvider {
        static var previews: some View {
            InfoPageOneView()
        }
    }
#endif
