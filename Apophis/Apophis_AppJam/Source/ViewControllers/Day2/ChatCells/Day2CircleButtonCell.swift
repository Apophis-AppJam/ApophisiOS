//
//  Day2CircleButtonCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/05.
//

import UIKit

class Day2CircleButtonCell: UITableViewCell {

    
    
    @IBOutlet weak var circleButton: UIButton!
    
    var messageType : messageTypeList?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func ButtonClicked(_ sender: Any) {
        
        
        if messageType == .brightAndDark
        {
            NotificationCenter.default.post(name: NSNotification.Name("setBrightAndDark"), object: nil)
            
        }
        else if messageType == .setTimeButton
        {
            NotificationCenter.default.post(name: NSNotification.Name("setTimeButtonClicked"), object: nil)
        }
        else if messageType == .selectValue
        {
            NotificationCenter.default.post(name: NSNotification.Name("setValueButtonClicked"), object: nil)
        }
        else if messageType == .setEraseButton
        {
            print("셀 버튼 눌리니?")
            NotificationCenter.default.post(name: NSNotification.Name("setEraseButtonClicked"), object: nil)
        }
        
        
        

    }
    
    
    func setData(type : messageTypeList)
    {
        if type == .brightAndDark
        {
            messageType = .brightAndDark
            circleButton.setBackgroundImage(UIImage(named: "findLightDark"), for: .normal)
            
        }
        else if type == .setTimeButton
        {
            
            messageType = .setTimeButton

            circleButton.setBackgroundImage(UIImage(named: "btnTimer"), for: .normal)
        }
        else if type == .selectValue
        {
            messageType = .selectValue
            circleButton.setBackgroundImage(UIImage(named: "selectValue"), for: .normal)
            
        } else if type == .setEraseButton
        {
            messageType = .setEraseButton
            circleButton.setBackgroundImage(UIImage(named: "btn_dirt"), for: .normal)
        }
        
        
        circleButton.alpha = 0
    }
    
    
    func loadingAnimate(index : Int)
    {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .allowUserInteraction) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.circleButton.alpha = 1
            })

        } completion: { (_) in
        }
        
    }
    
    func showMessageWithNoAnimation()
    {
        self.circleButton.alpha = 1
    }
    
    

}
