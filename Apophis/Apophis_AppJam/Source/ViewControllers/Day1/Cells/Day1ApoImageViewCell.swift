//
//  Day1ApoImageViewCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/12.
//

import UIKit
import Kingfisher

class Day1ApoImageViewCell: UITableViewCell {

    
    @IBOutlet weak var hyeYuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func setImageView(imgUrl: String){
        
        hyeYuImage.layer.cornerRadius = 8.5
        hyeYuImage.layer.masksToBounds = true
        hyeYuImage.setImage(with: imgUrl)
        print("이거 잘 되고 있는거 맞지??", imgUrl)
    }
    
    func loadingAnimate(idx : Int)
    {
  
        NotificationCenter.default.post(name: NSNotification.Name("scrollToBottom"), object: nil)

        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .allowUserInteraction) {
            

                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                    
                    self.hyeYuImage.alpha = 1
                })
                

            

            
            
        } completion: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name("AponimousMessageEnd"), object: idx)

        }


 
    }
    
    func showMessageWithNoAnimation()
    {
        hyeYuImage.alpha = 1
    }
}
