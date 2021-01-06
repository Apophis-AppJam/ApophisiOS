//
//  Day2SelectListCollectionCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/03.
//

import UIKit

class Day2SelectListCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var selectTextLabel: UILabel!
    
    
    func setSelectData(isSelected : Bool, title : String)
    {
        selectTextLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        if isSelected
        {
            backgroundImageView.image = UIImage(named: "selected_answer_background")
            selectTextLabel.textColor = .white
        }
        else
        {
            backgroundImageView.image = UIImage(named: "unselected_answer_background")
            selectTextLabel.textColor = .init(red: 171/255, green: 112/255, blue: 245/255, alpha: 1)
        }
        
        selectTextLabel.text = title
    }
    
    
}
