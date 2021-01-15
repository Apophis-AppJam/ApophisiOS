//
//  ChatDayEndMessageCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/15.
//

import UIKit

class ChatDayEndMessageCell: UITableViewCell {
    //MARK:- IBOutlet Part

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var moonImageView: UIImageView!
    
    
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
    
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("dayChatEnd"), object: nil)

    }
    
    

    
    //MARK:- default Setting Function Part
    
    func setFont()
    {
        titleLabel.font = .gmarketFont(weight: .Medium, size: 14)
        label1.font = .gmarketFont(weight: .Medium, size: 12)
        
    }

    
    //MARK:- Function Part
    
    
    func defaultSetting()
    {
        self.backgroundImageView.alpha = 0
        self.completeButton.alpha = 0
        self.label1.alpha = 0
        self.titleLabel.alpha = 0
        self.moonImageView.alpha = 0
        
        self.completeButton.isEnabled = false
    }
    
    func loadingAnimate()
    {
  


        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .allowUserInteraction) {
            

                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                    
                    self.backgroundImageView.alpha = 1
                    self.completeButton.alpha = 1
                    self.label1.alpha = 1
                    self.titleLabel.alpha = 1
                    self.moonImageView.alpha = 1
                })
                

            

            
            
        } completion: { (_) in
            self.completeButton.isEnabled = true

            
        }


 
    }
    
    func showMessageWithNoAnimation()
    {
        self.completeButton.isEnabled = true
        self.backgroundImageView.alpha = 1
        self.completeButton.alpha = 1
        self.label1.alpha = 1
        self.titleLabel.alpha = 1
        self.moonImageView.alpha = 1
    }


}

//MARK:- extension 부분

