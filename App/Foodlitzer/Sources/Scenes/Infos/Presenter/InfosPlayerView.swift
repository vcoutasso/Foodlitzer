//
//  InfosPlayerView.swift
//  SpiderVerse
//
//  Created by Bruna Naomi Yamanaka Silva on 19/11/21.
//

import SwiftUI

struct InfosPlayerView: View {
    var body: some View {
        ZStack {
            PlayerView()
                .ignoresSafeArea()
        }
    }
}

#if DEBUG
    struct InfosPlayerView_Previews: PreviewProvider {
        static var previews: some View {
            InfosPlayerView()
        }
    }
#endif
