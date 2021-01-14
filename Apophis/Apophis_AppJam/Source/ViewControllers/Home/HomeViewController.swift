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

    

    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAudio()

    }
    
    //MARK:- IBAction Part

    
    
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
    
    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part
    
    
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

