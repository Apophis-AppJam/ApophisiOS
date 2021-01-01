//
//  ChatMyMessageCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class ChatMyMessageCell: UITableViewCell {
    //MARK:- IBOutlet Part
    
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
        
//        messageTextView.translatesAutoresizingMaskIntoConstraints = true
//        messageTextView.contentInset = .zero
//        messageTextView.textContainerInset = .zero
    }


}

//MARK:- extension 부분

