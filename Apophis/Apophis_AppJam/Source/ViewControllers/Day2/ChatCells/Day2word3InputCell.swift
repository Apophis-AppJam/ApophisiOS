//
//  Day2word3InputCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/06.
//

import UIKit

class Day2word3InputCell: UITableViewCell {
    
    
    
    @IBOutlet weak var textStackView: UIStackView!
    
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setTextField()
    {

        completeLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        completeLabel.textColor = .init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        completeButton.isHidden = true
        self.textStackView.alpha = 0
        self.completeLabel.alpha = 0
        
        
        // 채팅창 닫기버튼 만들기
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        
        let normalAttributes : [NSAttributedString.Key: Any] = [
            .font : UIFont.gmarketFont(weight: .Medium, size: 14),
            .foregroundColor : UIColor.white
            ]


        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissKeyBoard))
        button.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        
        toolBar.setItems([flexSpace,button], animated: true)
        toolBar.isUserInteractionEnabled = true

        toolBar.tintColor = .white

        toolBar.barTintColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        textField1.textColor = .mainColor
        textField2.textColor = .mainColor
        textField3.textColor = .mainColor
        
        textField1.inputAccessoryView = toolBar
        textField2.inputAccessoryView = toolBar
        textField3.inputAccessoryView = toolBar
        
        textField1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textField1.addTarget(self, action: #selector(hideInputView), for: .editingDidBegin)
        textField2.addTarget(self, action: #selector(hideInputView), for: .editingDidBegin)
        textField3.addTarget(self, action: #selector(hideInputView), for: .editingDidBegin)
        
        
    }
    
    @objc func hideInputView()
    {
        NotificationCenter.default.post(name: NSNotification.Name("hideInputView"), object: nil)
    }
    
    @objc func textFieldDidChange()
    {

        
        if !textField1.text!.isEmpty &&
            !textField2.text!.isEmpty &&
            !textField3.text!.isEmpty  {
            
            completeLabel.textColor = .mainColor
            completeButton.isHidden = false
            
        }
        else
        {
            completeLabel.textColor = .init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
            completeButton.isHidden = true
        }
    }
    
    
    
    @objc func dismissKeyBoard()
    {
        self.endEditing(true)
    }
    
    func loadingAnimate(index : Int)
    {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .allowUserInteraction) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.textStackView.alpha = 1
                self.completeLabel.alpha = 1
                
            })

        } completion: { (_) in
        }
        
    }
    
    func showMessageWithNoAnimation()
    {
        self.textStackView.alpha = 1
        self.completeLabel.alpha = 1
    }
    
    
    
    
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        
        if !textField1.text!.isEmpty && !textField2.text!.isEmpty && !textField3.text!.isEmpty  {
            
            var wordList : [String] = []
            
            wordList.append(contentsOf: [textField1.text!, textField2.text!, textField3.text!])
            
            NotificationCenter.default.post(name: NSNotification.Name("user3WordsEntered"), object: wordList)
        }
    }
    
    
}

