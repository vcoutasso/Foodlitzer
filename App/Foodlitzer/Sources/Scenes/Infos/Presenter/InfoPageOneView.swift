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
            VStack(spacing: 0){
                Spacer()
                HStack{
                    Image("locationicon")
                        .resizable()
                        .frame(width: 10, height: 15)
                    Text("Avenida Getúlio Vargas, 3030")
                }
                .font(.system(size: 14, weight: .regular))
                .frame(width: 350, height: 30)
                .background(Color(.white))
                .border(Color.black, width: 0.2)
                HStack(spacing: 0) {
                    HStack(spacing: 0){
                        Image("GoogleIcon")
                            .padding(.horizontal, 7)
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
                    }
                    .font(.system(size: 10, weight: .regular))
                    .frame(width: 175, height: 30)
                    .background(Color(.white))
                    .border(Color.black, width: 0.2)
                    HStack{
                        Image(systemName: "dollarsign.circle")
                        Text("$$$$")
                    }
                    .font(.system(size: 14, weight: .light))
                    .frame(width: 175, height: 30)
                    .background(Color(.white))
                    .border(Color.black, width: 0.2)
                
                }
                HStack{
                    Image("FoodlitzerIcon")
                        .padding(.horizontal, 7)
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup.fill")
                    Image(systemName: "hand.thumbsup")
                }
                .font(.system(size: 14, weight: .regular))
                .frame(width: 350, height: 30)
                .background(Color(.white))
                .border(Color.black, width: 0.2)
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
