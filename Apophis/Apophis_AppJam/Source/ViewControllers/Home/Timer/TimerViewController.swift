//
//  TimerViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/12.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    
    
    //MARK:- IBOutlet Part

    @IBOutlet weak var apoStoneImageView: UIImageView!
    
    
    @IBOutlet weak var dayDescriptionLabel: UILabel!
    @IBOutlet weak var hourDescriptionLabel: UILabel!
    @IBOutlet weak var minuteDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
    
    @IBOutlet weak var distanceDescriptionLabel: UILabel!
    @IBOutlet weak var distanceCountLabel: UILabel!
    @IBOutlet weak var kmDescriptionLabel: UILabel!
    
  
    
    
    @IBOutlet weak var lineTimerImageView: UIImageView!
    
    
    
    //MARK:- Variable Part
    
    var mTimer : Timer?
    var distanceTimer : Timer?
    
    var remainCount : Int = 0
    var remainCountInMilli : Float = 0
    
    var remainDay : Int = 7

    

    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        dayLabel.alpha = 0
        hourLabel.alpha = 0
        minuteLabel.alpha = 0
        secondLabel.alpha = 0
        distanceCountLabel.alpha = 0
        
        
        
        
        setRemainSecond()
        fontSetting()
       
        rotateAnimation(imageView: apoStoneImageView)
        startCount()
        

        

        
        
        
        UserDefaults.standard.setValue(6, forKey: "remainUserDay")
        
 

    }
    
    //MARK:- IBAction Part
    

    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
    //MARK:- default Setting Function Part
    
    
    func fontSetting()
    {
        dayDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        hourDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        minuteDescriptionLabel.font  = .gmarketFont(weight: .Light, size: 16)
        secondDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        
        dayLabel.font = .gmarketFont(weight: .Light, size: 50)
        hourLabel.font = .gmarketFont(weight: .Light, size: 50)
        minuteLabel.font = .gmarketFont(weight: .Light, size: 50)
        secondLabel.font = .gmarketFont(weight: .Light, size: 50)
        
        distanceDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        kmDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        distanceCountLabel.font = .gmarketFont(weight: .Light, size: 32)
        
        
        
    }
    
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 200) {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount = .infinity

            imageView.layer.add(rotateAnimation, forKey: nil)
        }

    //MARK:- Function Part

    func setRemainSecond()
    {
        switch(UserDefaults.standard.integer(forKey: "remainUserDay"))
        {
        case 0:
            dayLabel.text = "0"
            remainCount = 64652
            remainCountInMilli = 64652
            lineTimerImageView.image = UIImage(named: "img_apodistance_01")
        case 1:
            dayLabel.text = "1"
            remainCount = 59508
            remainCountInMilli = 59508
            lineTimerImageView.image = UIImage(named: "img_apodistance_02")
        case 2:
            dayLabel.text = "2"
            remainCount = 56291
            remainCountInMilli = 56291
            lineTimerImageView.image = UIImage(named: "img_apodistance_03")
        case 3:
            dayLabel.text = "3"
            remainCount = 64652
            remainCountInMilli = 64652
            lineTimerImageView.image = UIImage(named: "img_apodistance_04")
        case 4:
            dayLabel.text = "4"
            remainCount = 59812
            remainCountInMilli = 59812
            lineTimerImageView.image = UIImage(named: "img_apodistance_05")
        case 5:
            dayLabel.text = "5"
            remainCount = 44370
            remainCountInMilli = 44370
            lineTimerImageView.image = UIImage(named: "img_apodistance_06")
            
        case 6:
            dayLabel.text = "6"
            remainCount = 64280
            remainCountInMilli = 64280
            lineTimerImageView.image = UIImage(named: "img_apodistance_07")
            
        default:
            dayLabel.text = "6"
            remainCount = 41251
            remainCountInMilli = 41251
            lineTimerImageView.image = UIImage(named: "img_apodistance_07")

        }
    }
    
    
    func startCount()
    {
        
 
        
        if let timer = mTimer {
            //timer 객체가 nil 이 아닌경우에는 invalid 상태에만 시작한다
            if !timer.isValid {
                /** 1초마다 timerCallback함수를 호출하는 타이머 */
                mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
                
                distanceTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(distanceCount), userInfo: nil, repeats: true)
                
            }
        }else{
            //timer 객체가 nil 인 경우에 객체를 생성하고 타이머를 시작한다
            /** 1초마다 timerCallback함수를 호출하는 타이머 */
            mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            
            distanceTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(distanceCount), userInfo: nil, repeats: true)
        }
        
        UIView.animate(withDuration: 1.5, delay: 1, options: .curveEaseIn, animations: {
            self.dayLabel.alpha = 1
            self.hourLabel.alpha = 1
            self.minuteLabel.alpha = 1
            self.secondLabel.alpha = 1
            self.distanceCountLabel.alpha = 1
        }, completion: nil)

    }
    
    @objc func timerCallback(){
        remainCount -= 1
        setTime()
    }
    
    
    @objc func distanceCount()
    {
        remainCountInMilli -= 0.01
        let day = UserDefaults.standard.integer(forKey: "remainUserDay")
        let second = day * 86400
        let percent = (Float(second) + remainCountInMilli) / Float(604800)
        
        
        distanceCountLabel.text = String(normalize(140000 * percent))
        
    }
    
    let normalize: ((Float) -> Float) = { (input) in
        return round(input * 1000) / 10000
    } // 소수점 3자리까지 처리 하는 함수
    
    
    func setTime() // 하루는 86400
    {
        let hour = Int(remainCount / 3600)
        let minute = Int((remainCount % 1440) / 60)
        let second = Int(remainCount % 60)
        
        hourLabel.text = String(hour)
        minuteLabel.text = String(minute)
        secondLabel.text = String(second)
        
        
    }



}
//MARK:- extension 부분
