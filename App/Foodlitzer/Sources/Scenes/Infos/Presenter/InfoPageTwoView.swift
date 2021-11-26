//
//  InfoPageTwoView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageTwoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Iluminação")
                .modifier(Indicadores())
                .padding(4)
                .background(Color.black)
            HStack {
                Image(systemName: "lightbulb")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0) {
                        Text("Pouco iluminado")
                            .modifier(Indicadores())
                        Spacer()
                        Text("Muito iluminado")
                            .modifier(Indicadores())
                    }
                    .frame(width: 278)
                }
            }
            Text("Tempo de espera")
                .modifier(Indicadores())
                .padding(4)
                .background(Color.black)
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0) {
                        Text("Muito Rápido")
                            .modifier(Indicadores())
                        Spacer()
                        Text("Muito lento")
                            .modifier(Indicadores())
                    }
                    .frame(width: 278)
                }
            }
            Text("Som ambiente")
                .modifier(Indicadores())
                .padding(4)
                .background(Color.black)
            HStack {
                Image(systemName: "waveform")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                VStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 278, height: 10, alignment: .leading)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100, height: 10, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 0) {
                        Text("Silencioso")
                            .modifier(Indicadores())
                            .padding(.leading, 0)
                        Spacer()
                        Text("Barulhento")
                            .modifier(Indicadores())
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
