//
//  ChatYourMessageCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class ChatYourMessageCell: UITableViewCell {
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var messageTextView: UITextView!
    
    
    //MARK:- Variable Part

    
    
    //MARK:- Constraint Part

    
    
    //MARK:- Life Cycle Part

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    
    //MARK:- IBAction Part
    
    

    //MARK:- default Setting Function Part
    
    func setMessage(message : String)
    {
  
        
        let padding = messageTextView.textContainer.lineFragmentPadding
        messageTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        messageTextView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextView.textColor = .white
        messageTextView.text = message

        messageTextView.sizeToFit()
        
        messageTextView.translatesAutoresizingMaskIntoConstraints = true
        messageTextView.isScrollEnabled = false
        messageTextView.contentInset = .zero
        

    

        
    }
    
    

    //MARK:- Function Part


}

//MARK:- extension 부분

