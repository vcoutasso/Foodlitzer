//
//  Modifiers.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 26/11/21.
//

import SwiftUI

struct FontePadrao: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .light))
            .background(Color(.white))
            .border(Color.black, width: 0.2)
    }
}

struct SimbolosPadrao: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .regular))
            .foregroundColor(.white)
    }
}
struct Indicadores: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .light))
            .foregroundColor(.white)
    }
}

struct ButtonAction: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .light))
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .frame(width: 142)
            .background(Color(.black))
    }
}
