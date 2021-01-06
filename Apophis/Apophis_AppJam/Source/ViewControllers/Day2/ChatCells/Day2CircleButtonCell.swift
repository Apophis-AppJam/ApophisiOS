//
//  Day2CircleButtonCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/05.
//

import UIKit

class Day2CircleButtonCell: UITableViewCell {

    
    @IBOutlet weak var circleButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func ButtonClicked(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("setTimeButtonClicked"), object: nil)
    }
    
    
    func setData()
    {
        circleButton.alpha = 0
    }
    
    
    func loadingAnimate(index : Int)
    {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .allowUserInteraction) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.circleButton.alpha = 1
                
            })

        } completion: { (_) in
        }
        
    }
    
    func showMessageWithNoAnimation()
    {
        self.circleButton.alpha = 1
    }
    
    

}
