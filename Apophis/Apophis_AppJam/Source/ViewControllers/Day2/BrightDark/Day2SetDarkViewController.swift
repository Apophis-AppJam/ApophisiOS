//
//  Day2SetDarkViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/08.
//

import UIKit

class Day2SetDarkViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK:- Variable Part
    
    var brightContent : String = ""
    

    //MARK:- Constraint Part
    

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        etcSetting()
        setTextField()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
                
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyBoard()
    {
        self.view.endEditing(true)
    }
    
    
    //MARK:- IBAction Part

    @IBAction func completeButtonClicked(_ sender: Any) {
        
        var reason : [String] = []
        reason.append(contentsOf: [brightContent,contentTextView.text])
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("brightDarkComplete"), object: reason)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- default Setting Function Part
    
    func setTextField()
    {
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
        
        contentTextView.inputAccessoryView = toolBar
        
    }
    

    
    func etcSetting()
    {
        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 14)
        contentTextView.font = .gmarketFont(weight: .Medium, size: 14)
        contentTextView.text = "텍스트를 입력하세요"
        
        let padding = contentTextView.textContainer.lineFragmentPadding
        
        contentTextView.delegate = self
        contentTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        contentTextView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = true
        self.completeButton.isEnabled = false
        
    }
    
    //MARK:- Function Part


}
//MARK:- extension 부분

extension Day2SetDarkViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {


        
        if contentTextView.text == "텍스트를 입력하세요"
        {
            contentTextView.text = ""
            textView.textColor = .white
        }
        
        
    }
    

    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "텍스트를 입력하세요"
            
            
            textView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)

            self.completeButton.isEnabled = false
            self.completeButton.setBackgroundImage(UIImage(named: "btn_complete_unact"), for: .normal)

        }
    }
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == contentTextView && textView.text != ""
        {
            
            self.completeButton.isEnabled = true
            self.completeButton.setBackgroundImage(UIImage(named: "btn_complete_act"), for: .normal)

        }
        
        
        if textView == contentTextView && textView.text == ""
        {
            self.completeButton.isEnabled = false
            self.completeButton.setBackgroundImage(UIImage(named: "btn_complete_unact"), for: .normal)

        }
        
        
    }
    
}
