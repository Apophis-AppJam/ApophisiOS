//
//  placeHolderColor.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/08.
//

import Foundation
import UIKit


extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
