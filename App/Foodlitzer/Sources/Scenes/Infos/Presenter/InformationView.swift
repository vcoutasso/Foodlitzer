//
//  InformationView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InformationView: View {
    // MARK: Atributos

    var body: some View {
        ZStack {
            PlayerView()
                .ignoresSafeArea()
            TabView {
                InfoPageOneView()
                InfoPageTwoView()
                InfoPageThreeView()
                    .ignoresSafeArea()
                InfoPageFourView()
            }
            TopInfoView()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}

#if DEBUG
    struct InformationView_Previews: PreviewProvider {
        static var previews: some View {
            InformationView()
        }
    }
#endif
