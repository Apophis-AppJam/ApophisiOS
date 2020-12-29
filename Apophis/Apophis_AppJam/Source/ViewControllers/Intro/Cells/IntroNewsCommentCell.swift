//
//  IntroNewsCommentCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/29.
//

import UIKit

class IntroNewsCommentCell: UITableViewCell {
    //MARK:- IBOutlet Part

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
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
    
    
    
    
    func setMessage(time : String,
                    name :String,
                    message : String)
    {
        timeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 11)
        nicknameLabel.font = UIFont.gmarketFont(weight: .Medium, size: 11)
        commentLabel.font = UIFont.gmarketFont(weight: .Medium, size: 11)
        
        timeLabel.text = time
        nicknameLabel.text = name
        commentLabel.text = message
        
        
    }

    


}

//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }
