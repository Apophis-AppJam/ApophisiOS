//
//  textView Spacing.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/13.
//

import Foundation
import UIKit


extension UITextView {
    
    
    
    func addCharacterSpacing(kerningValue : Double = 3)
    
    {
        
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern,
                                          value : kerningValue,
                                          range : NSRange(location: 0, length: attributedString.length - 1))
            
            attributedText = attributedString
        }
    }
    
    



    
}

