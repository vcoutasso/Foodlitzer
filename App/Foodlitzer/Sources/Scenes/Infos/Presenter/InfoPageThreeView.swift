//
//  InfoPageThreeView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageThreeView: View {
    @State private var showAlert = false

    var imagens: [String] = ["imagem1", "imagem1", "imagem1", "imagem1", "imagem1"]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(imagens, id: \.self) { imagem in
                    Image(imagem)
                        .padding(.vertical, 10)
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

#if DEBUG
    struct InfoPageThreeView_Previews: PreviewProvider {
        static var previews: some View {
            InfoPageThreeView()
                .ignoresSafeArea()
                .background(.gray)
        }
    }
#endif
