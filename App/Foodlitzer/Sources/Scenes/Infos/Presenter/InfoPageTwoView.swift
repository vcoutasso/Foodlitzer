//
//  InfoPageTwoView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageTwoView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("Iluminação")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .padding(4)
                .background(Color.black)
            HStack(){
                Image(systemName: "lightbulb")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0){
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0){
                        Text("Pouco iluminado")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Muito iluminado")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                    }
                    .frame(width: 278)
                }
            }
            Text("Tempo de espera")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .padding(4)
                .background(Color.black)
            HStack(){
                Image(systemName: "clock")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0){
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0){
                        Text("Muito Rápido")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Muito lento")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                    }
                    .frame(width: 278)
                }
            }
            Text("Som ambiente")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .padding(4)
                .background(Color.black)
            HStack(){
                Image(systemName: "waveform")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0){
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0){
                        Text("Silencioso")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                            .padding(.leading, 0)
                        Spacer()
                        Text("Barulhento")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                            .padding(.trailing, 0)
                    }
                    .frame(width: 278)
                }
            }
        }
        .frame(width: 350)
        .padding(.vertical, 50)
    }
}
#if DEBUG
struct InfoPageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPageTwoView()
    }
}
#endif
