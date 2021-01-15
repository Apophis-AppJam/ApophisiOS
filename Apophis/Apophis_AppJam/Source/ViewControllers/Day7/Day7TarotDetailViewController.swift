//
//  Day7TarotDetailViewController.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/15.
//

import UIKit

struct backToTarotContentModel {
    var index: Int
    var contents: String
}

class Day7TarotDetailViewController: UIViewController {

    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var tarotDetailTextView: UITextView!
    @IBOutlet weak var tarotDetailQuestion: UILabel!
    @IBOutlet weak var textCount: UILabel!
    
    //MARK:- Variable Part
    
    var questionList : [String] = ["죽기 전 돌아봤을 때 \n 넌 네가 되고 싶었던 네 자신이 있었어?", "해보고 싶었는데 \n 안해봐서 억울한 게 있어?", "한 번 쯤 하고 싶었는데 \n 못해본 말이 있을까?", "이 마지막 순간에 \n 머리 속에 떠오르는 사람은 누구야? ", "그 사람에게 \n 꼭 전하고 싶었던 말이 뭐야?", "곧 마지막인 지금 이 순간 \n 너에게 꼭 해주고 싶은 말이 있어?", "소리내서 그걸 자기 스스로에게 말해줘.", "죽은 너에게 해주고 싶은 말은 뭐야?", "넌 어떤 사람으로 기억되고 싶어?" ]
    
    var detailIndex: Int = 99
    
    var backToTarotContent: backToTarotContentModel?
    
    //MARK:- Constraint Part
    
    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
    }
    
    
    //MARK:- IBAction Part
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tarotTextEnd(_ sender: Any) {
        
        let data = backToTarotContentModel.init(index: detailIndex, contents: tarotDetailTextView.text)
        
        NotificationCenter.default.post(name: NSNotification.Name("backToTarot"), object: data)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- default Setting Function Part

    func setTextView() {
        
         let style = NSMutableParagraphStyle()
        style.lineSpacing = 20.3
         let attributes = [NSAttributedString.Key.paragraphStyle : style]
        tarotDetailTextView.attributedText = NSAttributedString(string:
             
             " ", attributes:attributes)
        tarotDetailTextView.font = .gmarketFont(weight: .Medium , size: 12)
        tarotDetailTextView.textColor = .white
        
        textCount.alpha = 0
        
        for i in 0 ... questionList.count-1{
            if detailIndex == i{
                tarotDetailQuestion.text = questionList[i]
            }
        }
         
    }
    
 
    
    //MARK:- @objc func 부분

    
    
    //MARK:- Function Part
    
    
}
    //MARK:- extension 부분

    


