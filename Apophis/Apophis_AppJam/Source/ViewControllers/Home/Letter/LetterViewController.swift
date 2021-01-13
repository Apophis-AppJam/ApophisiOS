//
//  LetterViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/13.
//

import UIKit

class LetterViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var letterContentTextView: UITextView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var writeLetterDescriptionLabel: UILabel!
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterContentTextView.alpha = 0
        fromLabel.alpha = 0
        
        setFont()
        makeText()
        
        
        

    }
    
    //MARK:- IBAction Part
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func writeButtonClicked(_ sender: Any) {
        
        guard let writeVC = self.storyboard?.instantiateViewController(identifier: "LetterWriteViewController") as? LetterWriteViewController else {return}
        
        
        self.navigationController?.pushViewController(writeVC, animated: true)
        
        
    }
    
    
    //MARK:- default Setting Function Part
    
    func setFont()
    {
     
       
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        letterContentTextView.attributedText = NSAttributedString(string:
            
            "너무 무서워 하지마. 아직 할 수 있는 많은 것들이 있어 너에게도 분명 무엇인가 가치있는 일이 있을거야", attributes:attributes)
        letterContentTextView.font = .chosunFont(size: 16)
        letterContentTextView.textColor = .white
        
        
        let padding = letterContentTextView.textContainer.lineFragmentPadding
        letterContentTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        

        fromLabel.font = .chosunFont(size: 16)
        
        writeLetterDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        
        
        
        
    }
    

    //MARK:- Function Part
    
    func makeText()
    {
        

        fromLabel.text = "from. 익명의 지구인"
        
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {
            self.letterContentTextView.alpha = 1
            self.fromLabel.alpha = 1

        }, completion: nil)
        
        
    }


}
//MARK:- extension 부분
