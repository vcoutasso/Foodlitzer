//
//  InfosPlayerViewModel.swift
//  SpiderVerse
//
//  Created by Bruna Naomi Yamanaka Silva on 19/11/21.
//

import AVFoundation
import Foundation
import SwiftUI

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do nothing here
    }

    func makeUIView(context: Context) -> some UIView {
        return QueuePlayerUIView(frame: .zero)
    }
}

class QueuePlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Load Video
        let randomInt = Int.random(in: 1..<6)
        let fileUrl = Bundle.main.url(forResource: String(randomInt), withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)

        // Setup Player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        // Loop
        self.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)

        // Play
        player.play()

        // Mute
        player.isMuted = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("ïnit(coder:) has not been implented")
    }
}
