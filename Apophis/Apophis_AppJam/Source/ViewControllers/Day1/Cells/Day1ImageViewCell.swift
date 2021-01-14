//
//  Day1ImageViewCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/03.
//

import UIKit

class Day1ImageViewCell: UITableViewCell {

    @IBOutlet weak var pictureImage: UIImageView!
    
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진을 저장할 변수
    var captureImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setPictureImage(ImgName: UIImage!){
        pictureImage.image = ImgName
    }
    
    func setImageView(){
        
        pictureImage.layer.cornerRadius = 8.5
        pictureImage.layer.masksToBounds = true
    }
    
    func loadingAnimate(idx : Int)
    {
        
        NotificationCenter.default.post(name: NSNotification.Name("scrollToBottom"), object: nil)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .allowUserInteraction) {
            
            
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.pictureImage.alpha = 1
            })
            
        } completion: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name("myMessageEnd"), object: idx)

        }
        
        
        
    }
    func showMessageWithNoAnimation()
    {
        pictureImage.alpha = 1
    }

}
