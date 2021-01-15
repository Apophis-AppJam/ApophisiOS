//
//  TarotCardCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/15.
//

import UIKit

class Day7TarotCardCell: UICollectionViewCell {
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var taroCardBackImageBtn: UIButton!
    
    @IBOutlet weak var imgMoon: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var lineBtn: UIButton!
    
    //MARK:- Variable Part
    static let identifier = "Day7TarotCardCell"
    var isTouch : Bool = false
    var questionList : [String] = ["죽기 전 돌아봤을 때 \n 넌 네가 되고 싶었던 네 자신이 있었어?", "해보고 싶었는데 \n 안해봐서 억울한 게 있어?", "한 번 쯤 하고 싶었는데 \n 못해본 말이 있을까?", "이 마지막 순간에 \n 머리 속에 떠오르는 사람은 누구야? ", "그 사람에게 \n 꼭 전하고 싶었던 말이 뭐야?", "곧 마지막인 지금 이 순간 \n 너에게 꼭 해주고 싶은 말이 있어?", "소리내서 그걸 자기 스스로에게 말해줘.", "죽은 너에게 해주고 싶은 말은 뭐야?", "넌 어떤 사람으로 기억되고 싶어?" ]
    
    var answerList : [String] = [" 텍스트를 입력하세요","텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"," 텍스트를 입력하세요"]
    //MARK:- Constraint Part

    
    
    //MARK:- Life Cycle Part

    
    
    
    //MARK:- IBAction Part
    
    @IBAction func tarotCardTouch(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("tarotCardSellected"), object: getIndexPath())

    }
    
    @IBAction func goToWrite(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("goToTarotDetail"), object: getIndexPath())
    }
    
    
    //MARK:- default Setting Function Part
    
    func setTarot()
    {
        
        taroCardBackImageBtn.isHidden = false
        imgMoon.alpha = 0
        questionLabel.alpha = 0
        AnswerLabel.alpha = 0
        lineBtn.isHidden = true
    }
     
    func setCard(isTouched:Bool, index:Int, dataCheck: Bool)
    {
        isTouch = isTouched
        if isTouch == false
        {
            taroCardBackImageBtn.isHidden = false
            imgMoon.alpha = 0
            questionLabel.alpha = 0
            AnswerLabel.alpha = 0
            lineBtn.isHidden = true
        }
        else
        {
            
            taroCardBackImageBtn.isHidden = true
            imgMoon.alpha = 1
            questionLabel.alpha = 1
            AnswerLabel.alpha = 1
            lineBtn.isHidden = false
            questionLabel.text = questionList[index]
            AnswerLabel.text = answerList[index]
            
            if dataCheck {
                AnswerLabel.textColor = .white
                AnswerLabel.alpha = 1

            }
            else{
                AnswerLabel.textColor = .white
                AnswerLabel.alpha = 0.3

            }
            
            
        }
    }

    
    func getIndexPath() -> Int {
            var indexPath = 0
            
            guard let superView = self.superview as? UICollectionView else {
                print("superview is not a UITableView - getIndexPath")
                return -1
            }
            
            indexPath = superView.indexPath(for: self)!.row
            return indexPath
        }
    
    func getTarotContents(contents: String, idx: Int){
        answerList[idx] = contents
        

    }
}
