//
//  Day7ErrorCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/15.
//

import UIKit

class Day7ErrorCell: UITableViewCell {
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
        messageTextView.alpha = 0.5
        messageTextView.text = message

        messageTextView.sizeToFit()
        
        messageBackgroundImageView.alpha = 0
        messageTextView.alpha = 0
        

    }
    
    
    func loadingAnimate(idx : Int)
    {
  
        NotificationCenter.default.post(name: NSNotification.Name("scrollToBottom"), object: nil)

        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: .allowUserInteraction) {
            

                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                    
                    self.messageBackgroundImageView.alpha = 1
                    self.messageTextView.alpha = 1
                    
                })
                

            

            
            
        } completion: { (_) in
            sleep(1)
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





