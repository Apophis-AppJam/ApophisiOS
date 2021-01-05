//
//  ChatMyMessageCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class ChatMyMessageCell: UITableViewCell {
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var messageBackgroundImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK:- IBAction Part

    
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
  
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .allowUserInteraction) {
            

                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                    
                    self.messageBackgroundImageView.alpha = 1
                    self.messageTextView.alpha = 1
                    
                })
                

            

            
            
        } completion: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name("myMessageEnd"), object: idx)
        }


 
    }
    
    func showMessageWithNoAnimation()
    {
        messageTextView.alpha = 1
        messageBackgroundImageView.alpha = 1
    }
    


}

//MARK:- extension 부분

