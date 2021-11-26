//
//  InformationView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InformationView<ViewModelType>: View where ViewModelType: InformationViewModelProtocol {
    // MARK: Atributos

    @ObservedObject private(set) var viewModel: ViewModelType

    // TODO: Conteúdo das páginas
    private let InformationPages = Array(1...5)

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
            InformationView(viewModel: InformationViewModel())
        }
    }
#endif
