//
//  ViewController.swift
//  MediaCreator
//
//  Created by Vladimir Udachin on 13.03.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let store = AssetStore.test()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        startPlaying(asset: store.compose())
    }
    
    private func startPlaying(asset: AVAsset) {
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }

}
