//
//  ViewController.swift
//  MediaCreator
//
//  Created by Vladimir Udachin on 13.03.2021.
//

import UIKit
import AVFoundation

class AssetStore {

    let video: AVAsset
    let video2: AVAsset
    let music: AVAsset
    
    init(video: AVAsset, video2: AVAsset, music: AVAsset) {
        self.video = video
        self.video2 = video2
        self.music = music
    }
    
    static func asset(_ resource: String, type: String) -> AVAsset {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else { fatalError() }
        let url = URL(fileURLWithPath: path)
        return AVAsset(url: url)
    }
    
    static func test() -> AssetStore {
        return AssetStore(video: asset("1", type: "mp4"),
                          video2: asset("2", type: "MOV"),
                          music: asset("track", type: "mp3"))
    }
    
    func compose() -> AVAsset {
        let composition = AVMutableComposition()
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else {
            fatalError()
        }
        guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else {
            fatalError()
        }
        
        
        func insetVideo(asset: AVAsset, at time: CMTime) {
            try? videoTrack.insertTimeRange(CMTimeRange(start: CMTime.zero, duration: asset.duration),
                                            of: asset.tracks(withMediaType: .video)[0],
                                            at: time)
        }
        
        insetVideo(asset: video, at: CMTime.zero)
        insetVideo(asset: video2, at: video.duration)
        
        
        try? audioTrack.insertTimeRange(CMTimeRange(start: CMTime.zero, duration: video.duration + video2.duration),
                                        of: music.tracks(withMediaType: .audio)[0],
                                        at: CMTime.zero)
        
        return composition
        
    }
    
//    func export(asset: AVAsset, completion: @escaping (Bool) -> Void) {
//        guard let documentDirectory = FileManager.default
//                .urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
//        let url
//        
//    }

}

