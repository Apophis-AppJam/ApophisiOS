//
//  Day2MusicPlayCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/16.
//

import UIKit
import Lottie
import AVFoundation

var soundPlayer : AVAudioPlayer?

class Day2MusicPlayCell: UITableViewCell {

    
    @IBOutlet weak var musicButton: UIButton!
    var loadingView = AnimationView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func defaultSetting()
    {
        musicButton.alpha = 0
    }
    
    
    func loadingAnimate(index : Int, vibrate : Bool)
    {
    
        guard let sound = soundEffect else { return }
        sound.stop()


        
        let url = Bundle.main.url(forResource: "day2Sound", withExtension: "mp3")
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url!)

            guard let sound = soundPlayer else { return }
            sound.numberOfLoops = 1
            sound.play()

        } catch let error {

            print(error.localizedDescription)

        }
        
        let time = DispatchTime.now() + .seconds(9)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            guard let sound = soundPlayer else { return }
            sound.stop()

            let url = Bundle.main.url(forResource: "main_bgm", withExtension: "mp3")
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url!)

                guard let sound = soundEffect else { return }
                sound.numberOfLoops = 100
                sound.play()

            } catch let error {

                print(error.localizedDescription)

            }

        }
        

        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .allowUserInteraction) {

            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2,animations: {
                    self.musicButton.alpha = 1
                    
                })
                

            
        } completion: { (_) in

            NotificationCenter.default.post(name: NSNotification.Name("AponimousMessageEnd"), object: index)


        }
    }
    
    

    func showMessageWithNoAnimation()
    {
        musicButton.alpha = 1
    }
    
    
    

    @IBAction func musicPlayButtonClicked(_ sender: Any) {
        
    }
}
