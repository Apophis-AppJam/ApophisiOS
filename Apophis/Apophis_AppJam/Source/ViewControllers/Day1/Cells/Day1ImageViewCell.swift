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
        print("이거 잘 되고 있는거 맞지??", pictureImage)
    }
    
    func setImageView(){
        
        pictureImage.layer.cornerRadius = 8.5
        pictureImage.layer.masksToBounds = true
    }

}
