//
//  GmarketFont + UIFont.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import Foundation
import UIKit

enum gmarketFontSize
{
    case Light
    case Bold
    case Medium
}


extension UIFont
{
    static func gmarketFont(weight: gmarketFontSize = .Medium, size : CGFloat = 12) -> UIFont
    {
        return UIFont(name: "GmarketSansTTF\(weight)", size: size)!
    }
    
    
    static func chosunFont(size : CGFloat = 14) -> UIFont
    {

        
        return UIFont(name: "ChosunilboNM", size: size)!
    }
}



