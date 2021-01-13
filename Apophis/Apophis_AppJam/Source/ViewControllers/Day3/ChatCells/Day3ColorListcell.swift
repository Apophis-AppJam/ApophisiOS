//
//  Day3ColorListcell.swift
//  Apophis_AppJam
//
//  Created by kong on 2021/01/13.
//

import UIKit

class Day3ColorListcell: UICollectionViewCell {
    
    
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var checkedImage: UIImageView!
    
    
//    var isChecked : Bool = false
    
    func getIndexPath() -> Int {
            var indexPath = 0
            
            guard let superView = self.superview as? UICollectionView else {
                return -1
            }
            indexPath = superView.indexPath(for: self)!.row
        
        


            return indexPath
        }
    
    
    func setCheck(isChekced : Bool)
    {
        if isChekced
        {
            checkedImage.isHidden = false
        }
        else
        {
            checkedImage.isHidden = true
        }
    }
    
    
    
    
    @IBAction func colorButtonClicked(_ sender: Any) {
        print("버튼이 눌리니?")
        
        NotificationCenter.default.post(name: NSNotification.Name("colorChecked"), object: getIndexPath())
        
}
}
