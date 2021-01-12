//
//  ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import UIKit

import AVFoundation


var soundEffect: AVAudioPlayer?

// 실험실 전용 뷰컨이라서 마구잡이로 쓸 예정임 !
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    @IBOutlet weak var day3Button: UIButton!
    @IBOutlet weak var day4Button: UIButton!
    @IBOutlet weak var day5Button: UIButton!
    @IBOutlet weak var day6Button: UIButton!
    @IBOutlet weak var day7Button: UIButton!
    @IBOutlet weak var HomeButton: UIButton!
    @IBOutlet weak var yukyungButton: UIButton!
    @IBOutlet weak var youngjaeButton: UIButton!
    @IBOutlet weak var jihunButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAudio()

        
        
        day1Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day2Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day3Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day4Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day5Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day6Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        day7Button.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        HomeButton.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        yukyungButton.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        youngjaeButton.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        jihunButton.titleLabel!.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
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




    @IBAction func goToSample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day1ViewController") as? Day1ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func goToDay2Sample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day2ViewController") as? Day2ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func goToDay3Sample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day3", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day3ViewController") as? Day3ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

