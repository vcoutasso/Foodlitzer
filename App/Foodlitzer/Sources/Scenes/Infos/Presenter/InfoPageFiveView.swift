//
//  InfoPageFiveView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageFiveView: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            ZStack(){
                Text("This restaurant has been reviewed 102 times by Foodlitzer's users. What would you like to do now?")
                    .font(.system(size: 14, weight: .light))
                    .padding()
                    .frame(width: 331, height: 126)
                    .background(Color(.white))
                    .border(Color.black, width: 0.2)
                
                HStack(){
                    Button ("Save"){
                    }
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white)
                    .padding(.vertical, 7)
                    .frame(width: 142)
                    .background(Color(.gray))
                    Button ("New Review"){
                    }
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white)
                    .padding(.vertical, 7)
                    .frame(width: 142)
                    .background(Color(.gray))
                }
                .padding(.top, 120)
            }
            
        }.padding(.vertical, 90)
    }
}
#if DEBUG
struct InfoPageFiveView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPageFiveView()
    }
}
#endif
