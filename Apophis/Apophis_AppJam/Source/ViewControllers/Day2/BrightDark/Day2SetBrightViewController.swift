//
//  Day2SetBrightViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/08.
//

import UIKit

class Day2SetBrightViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self
        etcSetting()
        setTextField()
    }
    
    //MARK:- IBAction Part
    
    
    @IBAction func backButtonClicked(_ sender: Any) {

        
        self.dismiss(animated: true, completion: nil)
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
    
    @objc func dismissKeyBoard()
    {
        self.view.endEditing(true)
    }
    func etcSetting()
    {
        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 14)
        contentTextView.font = .gmarketFont(weight: .Medium, size: 14)
        let padding = contentTextView.textContainer.lineFragmentPadding
        contentTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        
        contentTextView.text = "텍스트를 입력하세요"
        contentTextView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        
        
        self.nextButton.setBackgroundImage(UIImage(named: "nextBtnUnactivated"), for: .normal)

        self.nextButton.isEnabled = false
    }
    
    //MARK:- Function Part
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let darkVC = self.storyboard?.instantiateViewController(identifier: "Day2SetDarkViewController") as? Day2SetDarkViewController else {return}
        
        darkVC.brightContent = self.contentTextView.text
        self.navigationController?.pushViewController(darkVC, animated: true)
    }
    
}
//MARK:- extension 부분

extension Day2SetBrightViewController: UITextViewDelegate
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

            self.nextButton.isEnabled = false
            self.nextButton.setBackgroundImage(UIImage(named: "nextBtnUnactivated"), for: .normal)

        }
    }
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == contentTextView && textView.text != ""
        {
            
            self.nextButton.isEnabled = true
            self.nextButton.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)

        }
        
        
        if textView == contentTextView && textView.text == ""
        {
            self.nextButton.isEnabled = false
            self.nextButton.setBackgroundImage(UIImage(named: "nextBtnUnactivated"), for: .normal)

        }
        
        
    }
    
}
