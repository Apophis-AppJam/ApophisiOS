//
//  ChatDayEndViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/15.
//

import UIKit

class ChatDayEndViewController: UIViewController {
    
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var dayDescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var purpleTitleLabel: UILabel!
    @IBOutlet weak var completeContentLabel: UILabel!
    
    
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK:- Variable Part
    
    var day: Int = 1
    
    //MARK:- Constraint Part
    
    //MARK:- Life Cycle Part
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayDescriptionLabel.alpha = 0
        titleLabel.alpha = 0
        purpleTitleLabel.alpha = 0
        completeContentLabel.alpha = 0
        completeButton.alpha = 0
        completeButton.isEnabled = false
        
        makeFont()
        setFont()
        showFont()
        
    }
    
    //MARK:- IBAction Part
    
    @IBAction func goHomeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            // 여기에 노티 발사
            
            NotificationCenter.default.post(name: NSNotification.Name("backToHome"), object: nil)
        }
    }
    
    
    //MARK:- default Setting Function Part
    
    
    func makeFont()
    {
        purpleTitleLabel.text = "오늘 받은 메세지"
        if day == 1
        {
            dayDescriptionLabel.text = "멸망까지 엿새"
            titleLabel.text = "나침반이 가리키는 곳 : 여정의 시작"
            
            completeContentLabel.text = "어쩌면 그 '한 번쯤'은 \n없을지도 모른다고."
            
        }
        else if day == 2
        {
            dayDescriptionLabel.text = "멸망까지 닷새"
            titleLabel.text = "여러 갈래 길에 쌓이는 눈 : 당신의 가치"
            
            completeContentLabel.text = "너에게는 어떤 모습들이 있니? \n 빛이든 그림자든. 그 모습들은 전부 너일테니까."
        }
        else if day == 3
        {
            dayDescriptionLabel.text = "멸망까지 나흘"
            titleLabel.text = "당신의 모든 순간들"
        }
        else if day == 4
        {
            dayDescriptionLabel.text = "멸망까지 사흘"
            titleLabel.text = "당신의 모든 순간들"
        }
        else if day == 5
        {
            dayDescriptionLabel.text = "멸망까지 이틀"
            titleLabel.text = "당신의 모든 순간들"
        }
        else if day == 6
        {
            dayDescriptionLabel.text = "멸망까지 하루"
            titleLabel.text = "빛을 따라가는 등대지기 : 당신의 순간"
            
            completeContentLabel.text = "모든 것이 낯설어지는 건 \n아주 사소한 것에서 시작해."
        }
        else if day == 7
        {
            dayDescriptionLabel.text = "멸망의 날"
            titleLabel.text = "아포피스, 끝은 또 다른 시작 : 당신의 말"
            
            completeContentLabel.text = "사실 소행성은 언제나 \n우리 곁에 있었던 거야."
        }
        
        // 3 4 5 일차 정보는 수정되어야 함.
        
        completeContentLabel.sizeToFit()
    }
    
    
    func setFont()
    {
        dayDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        titleLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        purpleTitleLabel.font = .gmarketFont(weight: .Medium, size: 12)
                
        completeContentLabel.font = .gmarketFont(weight: .Medium, size: 14)
    }
    
    func showFont()
    {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .allowUserInteraction) {
            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2,animations: {
                    
                    self.dayDescriptionLabel.alpha = 1
                    self.titleLabel.alpha = 1
                    
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/2, animations: {
                    
                    self.purpleTitleLabel.alpha = 1
                    self.completeContentLabel.alpha = 1
                    self.completeButton.alpha = 1
                    
                    
                    
                    
                })
            
           
        } completion: { (_) in
            
            self.dayDescriptionLabel.alpha = 1
            self.titleLabel.alpha = 1
            self.purpleTitleLabel.alpha = 1
            self.completeContentLabel.alpha = 1
            self.completeButton.alpha = 1
            self.completeButton.isEnabled = true
            
        }
    }
    
    
    
    //MARK:- Function Part
    
    
}
//MARK:- extension 부분

