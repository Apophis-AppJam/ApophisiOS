//
//  IntroPhoneRingViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/29.
//

import UIKit
import AudioToolbox
import Lottie

import AVFoundation

var soundEffect: AVAudioPlayer?


class IntroPhoneRingViewController: UIViewController {

    
    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var starLottieView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var stoneImageView: UIImageView!
    
    
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var circleButtonDescriptionLabel: UILabel!
    
    @IBOutlet weak var chatBackgroundView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var label6: UILabel!
    
    @IBOutlet weak var label7: UILabel!
    
    
    @IBOutlet weak var label8: UILabel!
    
    
    @IBOutlet weak var label9: UILabel!
    //MARK:- Variable Part
    
    var mode : Int = 0
    var mTimer : Timer?
    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatLabel.alpha = 0
        label1.alpha = 0
        label2.alpha = 0
        label3.alpha = 0
        label4.alpha = 0
        label5.alpha = 0
        label6.alpha = 0
        label7.alpha = 0
        label8.alpha = 0
        label9.alpha = 0
        
        
        setFont()
        makeText()
        vibrate()
        

        chatBackgroundView.alpha = 0
        chatLabel.alpha = 0
        



      

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        rotateAnimation(imageView: stoneImageView)
    }
    
    //MARK:- IBAction Part

    @IBAction func phoneButtonClicked(_ sender: Any) {
        
        if mode == 0
        {    let loadingView = AnimationView()
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { timer in
               
     
               loadingView.frame = self.starLottieView.bounds
               loadingView.animation = Animation.named("fallingstar")
               loadingView.contentMode = .scaleAspectFit
               loadingView.loopMode = .loop
               
               
               self.starLottieView.addSubview(loadingView)
                
                loadingView.play()
               
               
           })
            
            
            
            playAudio()
            mTimer?.invalidate()
            self.chatBackgroundView.isHidden = false
            self.circleButtonDescriptionLabel.text = "끊기"
            self.locationLabel.text = "통화중 ..."
            
       
        
            UIView.animateKeyframes(withDuration: 50, delay: 0, options: .beginFromCurrentState) {
       
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0/116.0,animations: {
                    self.chatBackgroundView.alpha = 1
                })
                
                
                UIView.addKeyframe(withRelativeStartTime: Double(2.0/116.0), relativeDuration: Double(1.0/116.0),animations: {
                    
       
                    
                    self.chatLabel.alpha = 1
    
                })
                
                
                UIView.addKeyframe(withRelativeStartTime: Double(9.0/116.0), relativeDuration: Double(1.0/116.0),animations: {
                    
           
                    
                    self.chatLabel.alpha = 0
                    
                })
                

                UIView.addKeyframe(withRelativeStartTime: Double(10.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
         
                    self.label1.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(19.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
           
                    self.label1.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(20.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
             
                    self.label2.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(33.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label2.alpha = 0
                    
                })
                
                
                UIView.addKeyframe(withRelativeStartTime: Double(34.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label3.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(43.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label3.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(44.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label4.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(49.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label4.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(50.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label5.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(59.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label5.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(60.0/116.0), relativeDuration: Double(1.0/116.0) ,animations: {
                   
                    self.label6.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(75.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label6.alpha = 0
                    
                })
                
                
                UIView.addKeyframe(withRelativeStartTime: Double(76.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label7.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(87.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label7.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(88.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label8.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(99.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label8.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(100.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label9.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(113.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.label9.alpha = 0
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: Double(115.0/116.0), relativeDuration: Double(1.0/116.0), animations: {
                   
                    self.chatBackgroundView.alpha = 0
                    self.mode = 1
                    
                })
                
                
                
                
            } completion: { (_) in
                self.chatBackgroundView.isHidden = true
                self.circleButtonDescriptionLabel.text = "끊기"
                self.locationLabel.text = "연결이 끊어졌습니다.."
                self.mode = 1
                
            }
        }
        else if self.mode == 1
        {
            print("여긴 되고 있음")
//            self.mode = 0
            guard let startVC = self.storyboard?.instantiateViewController(identifier: "IntroBeginViewController") as? IntroBeginViewController else {return}
            
            startVC.modalTransitionStyle = .crossDissolve
            startVC.modalPresentationStyle = .fullScreen
            
            self.present(startVC, animated: true, completion: nil)
            
        }
      
        
    }
    
    //MARK:- default Setting Function Part
    
    func setFont()
    {
        
        nameLabel.font = .gmarketFont(weight: .Light, size: 36)
        locationLabel.font = .gmarketFont(weight: .Medium, size: 16)
        circleButtonDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        chatLabel.font = .gmarketFont(weight: .Medium, size: 16)
        chatLabel.textColor = .white
        
        label1.font = .gmarketFont(weight: .Medium, size: 16)
        label1.textColor = .white
        
        label2.font = .gmarketFont(weight: .Medium, size: 16)
        label2.textColor = .white
        
        label3.font = .gmarketFont(weight: .Medium, size: 16)
        label3.textColor = .white
        
        label4.font = .gmarketFont(weight: .Medium, size: 16)
        label4.textColor = .white
        
        label5.font = .gmarketFont(weight: .Medium, size: 16)
        label5.textColor = .white
        
        label6.font = .gmarketFont(weight: .Medium, size: 16)
        label6.textColor = .white
        
        label7.font = .gmarketFont(weight: .Medium, size: 16)
        label7.textColor = .white
        
        label8.font = .gmarketFont(weight: .Medium, size: 16)
        label8.textColor = .white
        
        label9.font = .gmarketFont(weight: .Medium, size: 16)
        label9.textColor = .white
        
        

    }
    func vibrate()
    
    {
        
    
    if let timer = mTimer {
        //timer 객체가 nil 이 아닌경우에는 invalid 상태에만 시작한다
        if !timer.isValid {
            /** 1초마다 timerCallback함수를 호출하는 타이머 */
            mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            
            
   
            
        }
    }else{
        //timer 객체가 nil 인 경우에 객체를 생성하고 타이머를 시작한다
        /** 1초마다 timerCallback함수를 호출하는 타이머 */
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)

    }
    
  
    }
    
    
    @objc func timerCallback()
    {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    func makeText()
    {
    
        chatLabel.text = "어, 드디어 받았다."
        label1.text = "안녕. 전화 잠깐 끊지 말아주라."
        label2.text = "방금 7일 후에 지구 멸망한다는 뉴스 속보 봤어?"
        label3.text = "남은 일주일을 어떻게 보낼 생각이야?"
        label4.text = "내가 누구냐고?"
        label5.text = "음.. 그냥 아무 번호나 찍어서 전화했어."
        label6.text = "죽기 전에 이런거 한 번쯤 해보고 싶었거든."
        label7.text = "사실 당황스럽겠지만,\n내가 연락할 사람이 한 명도 없어서 그러는데."
        label8.text = "남은 일주일 동안 나랑 연락하면서 지내주면 안될까?"
        label9.text = "만약 괜찮다면... 계속 연락하고 싶어."
    }

    
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

    
    
    
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 200) {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount = .infinity

            imageView.layer.add(rotateAnimation, forKey: nil)
        }

}
//MARK:- extension 부분
