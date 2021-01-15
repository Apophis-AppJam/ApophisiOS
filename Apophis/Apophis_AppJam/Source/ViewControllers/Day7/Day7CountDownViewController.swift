//
//  Day7CountDownViewController.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/16.
//

import UIKit
import AVKit
import AVFoundation

class Day7CountDownViewController: UIViewController {
    
    
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var CountDownView: UIView!
    
    
    //MARK:- Variable Part
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        
        let time = DispatchTime.now() + .seconds(12)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
//            UserDefaults.standard.setValue(true, forKey: "isMusicTurnOn")
//            
//            let url = Bundle.main.url(forResource: "main_bgm", withExtension: "mp3")
//            do {
//                soundEffect = try AVAudioPlayer(contentsOf: url!)
//
//                guard let sound = soundEffect else { return }
//                sound.numberOfLoops = 100
//                sound.play()
//
//            } catch let error {
//
//                print(error.localizedDescription)
//
//            }
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    private func playVideo() {
        let filepath: String? = Bundle.main.path(forResource: "countdown_realfin", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        
        self.avPlayer = AVPlayer(url: fileURL)
        self.avPlayerViewController.player = self.avPlayer
        self.avPlayerViewController.view.frame =
            CountDownView.bounds
        
        avPlayerViewController.showsPlaybackControls = false
        CountDownView.addSubview(avPlayerViewController.view)
        
        self.avPlayerViewController.player?.play()
    }
    
    //    private func playVideo() {
    //            guard let path = Bundle.main.path(forResource: "countdown", ofType:"mp4") else {
    //                debugPrint("countdown.mp4 not found")
    //                return
    //            }
    //            let player = AVPlayer(url: URL(fileURLWithPath: path))
    //            let playerController = AVPlayerViewController()
    //            playerController.player = player
    //            present(playerController, animated: false) {
    //                player.play()
    //            }
    //        }
    
}
