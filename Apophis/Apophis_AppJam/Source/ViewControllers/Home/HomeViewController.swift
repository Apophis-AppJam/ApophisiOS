//
//  HomeViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/09.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    //MARK:- IBOutlet Part

    @IBOutlet weak var musicGuideView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    
    
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var clickLabel: UILabel!
    

    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAudio()
        setFont()
        musicGuideView.alpha = 0
        
        if UserDefaults.standard.bool(forKey: "isFirstHome") == true
        {
            musicGuideView.isHidden = false
            
            UIView.animate(withDuration: 2, animations: {
                self.musicGuideView.alpha = 1
            }, completion: {(_) in
            
                UserDefaults.standard.setValue(false, forKey: "isFirstHome")
            
            })
            
            
            
        }
        else
        {
            musicGuideView.isHidden = true
        }
        
        UserDefaults.standard.setValue(true, forKey: "isMusicTurnOn")

    }
    
    //MARK:- IBAction Part

    
    
    @IBAction func musicSetButtonClicked(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "isMusicTurnOn") == true
        {
            UserDefaults.standard.setValue(false, forKey: "isMusicTurnOn")
            musicButton.setBackgroundImage(UIImage(named: "btn_music_unselect"), for: .normal)
            
            guard let sound = soundEffect else { return }
            sound.stop()

            
        }
        else
        {
            UserDefaults.standard.setValue(true, forKey: "isMusicTurnOn")
            musicButton.setBackgroundImage(UIImage(named: "btn_music_select"), for: .normal)
            
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
    }
    
    
    
    @IBAction func apophisTimerButtonClicked(_ sender: Any) {
        
        
        guard let timerVC = self.storyboard?.instantiateViewController(identifier: "TimerViewController") as? TimerViewController else {return}
        
        
        self.navigationController?.pushViewController(timerVC, animated: true)
        
    }
    
    
    @IBAction func phoneButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let labVC = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController else {return}
        
        
        self.navigationController?.pushViewController(labVC, animated: true)
        
        
    }
    
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        
        
        
        guard let timerVC = self.storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        
        
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
    
    
    @IBAction func bucketListButtonClicked(_ sender: Any) {
        
        guard let bucketVC = self.storyboard?.instantiateViewController(identifier: "BucketListViewController") as? BucketListViewController else {return}
        
        self.navigationController?.pushViewController(bucketVC, animated: true)
        
    }
    
    
    
    @IBAction func letterButtonClicked(_ sender: Any) {
        
        guard let letterVC = self.storyboard?.instantiateViewController(identifier: "LetterViewController") as? LetterViewController else {return}
        
        self.navigationController?.pushViewController(letterVC, animated: true)
        
    }
    
    
    @IBAction func musicGuideLayerButtonClicked(_ sender: Any) {
        
        UIView.animate(withDuration: 2) {
            self.musicGuideView.alpha = 0
        } completion: { (_) in
            self.musicGuideView.isHidden = true
        }

    }
    
    
    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part
    
    
    func setFont()
    {
        firstLabel.font = .gmarketFont(weight: .Medium, size: 14)
        secondLabel.font = .gmarketFont(weight: .Medium, size: 14)
        thirdLabel.font = .gmarketFont(weight: .Medium, size: 14)
        fourthLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        fifthLabel.font = .gmarketFont(weight: .Medium, size: 12)
        clickLabel.font = .gmarketFont(weight: .Medium, size: 12)
    }
    
    
    func playAudio()
     {

         let url = Bundle.main.url(forResource: "main_bgm", withExtension: "mp3")

         if let url = url{


             do {

                 soundEffect = try AVAudioPlayer(contentsOf: url)

                 guard let sound = soundEffect else { return }
                 sound.numberOfLoops = 100


                 sound.play()

             } catch let error {

                 print(error.localizedDescription)

             }

         }

     }
    
    
    

}
//MARK:- extension 부분

