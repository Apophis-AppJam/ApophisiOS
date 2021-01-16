//
//  Day2UserAnswerCompleteCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/11.
//

import UIKit

class Day2UserAnswerCompleteCell: UITableViewCell {

    @IBOutlet weak var messageBackgroundImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var CompleteLabel: UILabel!
    @IBOutlet weak var CompleteButton: UIButton!
    
    
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
        self.CompleteLabel.textColor = .mainColor
        CompleteLabel.font = .gmarketFont(weight: .Medium, size: 14)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK:- IBAction Part

    @IBAction func completeButtonClicked(_ sender: Any) {
        
        print("완료하기 눌림")
        var userMessagerList : [String] = []
            
            userMessagerList.append(contentsOf: [messageTextView.text!])
            
            NotificationCenter.default.post(name: NSNotification.Name("userMessageEntered"), object: userMessagerList)
            
        }
        
    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part

    
    func setMessage(message : String)
    {
        
        
        
        let padding = messageTextView.textContainer.lineFragmentPadding
        messageTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        
        messageTextView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextView.textColor = .white
        messageTextView.text = message

        messageTextView.sizeToFit()
        
        messageBackgroundImageView.alpha = 0
        messageTextView.alpha = 0
        
        

    }
    
    
    func loadingAnimate(idx : Int)
    {
  
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .allowUserInteraction) {
            

                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                    
                    self.messageBackgroundImageView.alpha = 1
                    self.messageTextView.alpha = 1
                    
                })
                

            

            
            
        } completion: { (_) in

        }


 
    }
    
    func showMessageWithNoAnimation()
    {
        messageTextView.alpha = 1
        messageBackgroundImageView.alpha = 1
    }
    


}



//MARK:- extension 부분

