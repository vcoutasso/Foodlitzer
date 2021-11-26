//
//  TopInfoView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 26/11/21.
//

import SwiftUI

struct TopInfoView: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack() {
                Button {
                    showAlert = true
                } label: {
                    Label("", systemImage: "chevron.backward")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Bar do seu zé")
                    .frame(height: 33)
                    .font(.system(size: 14, weight: .light))
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .border(Color(.black), width: 0.2)
                Spacer()
                Button {
                    showAlert = true
                } label: {
                    Label("", systemImage: "info.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            
            HStack() {
                Image(systemName: "speaker.wave.3")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .alert(isPresented: $showAlert){
                Alert(title: Text("Info"), message: Text("As informações básicas sobre este restaurante são fornecidas pelo Google."), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
        .padding(.top, 10)
    }
}


struct TopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TopInfoView()
    }
}
