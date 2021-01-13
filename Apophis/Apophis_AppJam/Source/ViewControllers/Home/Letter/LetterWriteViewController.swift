//
//  LetterWriteViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/13.
//

import UIKit

class LetterWriteViewController: UIViewController {
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var letterContentTextView: UITextView!
    @IBOutlet weak var writeLetterDescriptionLabel: UILabel!
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        makeToolBar()
        addObserver()
    }
    
    //MARK:- IBAction Part

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func writeButtonClicked(_ sender: Any) {
        
    }
    
    

    
    
    //MARK:- default Setting Function Part
    
    func setFont()
    {
        letterContentTextView.font = .chosunFont(size: 16)
        letterContentTextView.delegate = self
        writeLetterDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        
        letterContentTextView.text = "텍스트를 입력하세요"

        letterContentTextView.textColor = .init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        
    }
    
    func addObserver()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        

    }
    
    
    func makeToolBar()
    {
        
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
        
        letterContentTextView.inputAccessoryView = toolBar
    }

    //MARK:- Function Part

    
    //MARK:- @objc func Part
    
    @objc func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
            self.textViewBottomConstraint.constant = keyboardSize.height + 150
            UIView.animate(withDuration: 0 , animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        
        self.textViewBottomConstraint.constant = 150
        
        
        self.view.layoutIfNeeded()
        
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }

}
//MARK:- extension 부분

extension LetterWriteViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1) {
            textView.text = nil
            textView.textColor = .white
        }
        
        if textView.text == "텍스트를 입력하세요"
        {
            
            letterContentTextView.text = ""
            textView.textColor = .white
        }
        
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            return true
        }
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "텍스트를 입력해주세요"

            textView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        }
    }
    
    
    
    
}

