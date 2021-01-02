//
//  ChatButtonCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/03.
//

import UIKit

class ChatButtonCell: UITableViewCell {

    @IBOutlet weak var ChatFuncButton: UIButton!
    
    var index: Int?
    var funcNum: Int?
    weak var viewController: UIViewController?
    
    
    @IBAction func ChatButtonAction(_ sender: Any) {
      
        guard let funcNum = funcNum else {return}
        if (funcNum == 1){
            print ("눌리냐?")
            
            let storyboard = UIStoryboard(name: "Day1", bundle: nil)
                        
            guard let vc = storyboard.instantiateViewController(identifier: "Day1CompassViewController") as? Day1CompassViewController else  {return}
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            viewController?.present(vc, animated: true, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Day1", bundle: nil)
            
            guard let vc = storyboard.instantiateViewController(identifier: "Day1CameraViewController") as? Day1CameraViewController else  {return}
            
            vc.modalTransitionStyle = .crossDissolve
            viewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setChatButton(ImgName: String){
        ChatFuncButton.setTitle("", for: .normal)
        ChatFuncButton.setBackgroundImage(UIImage(named: "\(ImgName)"), for: .normal)
    }
    

}
