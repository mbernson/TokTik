//
//  PlayerView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer?
    let videoGravity: AVLayerVideoGravity

    func makeUIView(context: Context) -> PlayerUIView {
        PlayerUIView(player: player)
    }

    func updateUIView(_ view: PlayerUIView, context: Context) {
        view.playerLayer.player = player
        view.playerLayer.videoGravity = videoGravity
    }
}

class PlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()

    init(player: AVPlayer?) {
        super.init(frame: .zero)
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

#Preview {
    let player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
    return PlayerView(player: player, videoGravity: .resizeAspectFill)
}
