//
//  BucketListViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/13.
//

import UIKit

class BucketListViewController: UIViewController {
    
    //MARK:- IBOutlet Part

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    
    
    @IBOutlet weak var bucketTitleLabel: UILabel!
    @IBOutlet weak var bucketContentTextView: UITextView!
    
    
    @IBOutlet weak var successButton: UIButton!
    
    @IBOutlet weak var dDayLabel: UILabel!
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bucketTitleLabel.alpha = 0
        bucketContentTextView.alpha = 0
        addButton.isEnabled = false
        
        
        setFont()
        makeText()

    }
    
    //MARK:- IBAction Part
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
    }
    

    //MARK:- default Setting Function Part
    
    
    func setFont()
    {
        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 16)
        
        addButton.titleLabel?.font = .gmarketFont(weight: .Medium, size: 14)
        
        bucketTitleLabel.font = .chosunFont(size: 16)
        
        
        dDayLabel.font = .gmarketFont(weight: .Light, size: 24)
        
        
        
        
         let style = NSMutableParagraphStyle()
         style.lineSpacing = 10
         let attributes = [NSAttributedString.Key.paragraphStyle : style]
        bucketContentTextView.attributedText = NSAttributedString(string:
             
             "너무 무서워 하지마. 아직 할 수 있는 많은 것들이 있어 너에게도 분명 무엇인가 가치있는 일이 있을거야", attributes:attributes)
        bucketContentTextView.font = .chosunFont(size: 14)
        bucketContentTextView.textColor = .white
         
         
         let padding = bucketContentTextView.textContainer.lineFragmentPadding
        bucketContentTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
         
         
        
        
    }

    //MARK:- Function Part
    
    func makeText()
    {
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut) {
            self.bucketTitleLabel.alpha = 1
            self.bucketContentTextView.alpha = 1
        }

 
    }

}
//MARK:- extension 부분
