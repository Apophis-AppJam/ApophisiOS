//
//  Day2SelectTimeViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/01.
//

import UIKit

class Day2SelectTimeViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var AMPMSelectSegment: UISegmentedControl!
    
    //MARK:- Variable Part
    
    var hourList : [String] = []
    var minuteList : [String] = []

    //MARK:- Constraint Part

    
    
    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setClockView()
        setSegment()
    }
    
    //MARK:- IBAction Part

    
    //MARK:- default Setting Function Part

    
    func setClockView()
    {
        clockView.layer.borderWidth = 1
        clockView.layer.borderColor = .init(red: 90/255, green: 79/255, blue: 99/255, alpha: 1)
    }
    
    func setSegment()
    {
        AMPMSelectSegment.layer.cornerRadius = 12
        
        
        let normalAttributes : [NSAttributedString.Key: Any] = [
            .font : UIFont.gmarketFont(weight: .Medium, size: 12),
            .foregroundColor : UIColor.init(red: 171/255, green: 112/255, blue: 245/255, alpha: 1)
            ]
        
        let selectedAttributes : [NSAttributedString.Key: Any] = [
            .font : UIFont.gmarketFont(weight: .Medium, size: 12),
            .foregroundColor : UIColor.white
            ]

        AMPMSelectSegment.setTitleTextAttributes(normalAttributes, for: .normal)
        AMPMSelectSegment.setTitleTextAttributes(selectedAttributes, for: .selected)

    }
    
    //MARK:- Function Part
    
    
    func createPickerView()
    {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.becomeFirstResponder()
        selectSemesterTextField.inputView = pickerView
        selectSemesterTextField.textColor = .clear
        
    }
    
    func dismissPickerView()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(done))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(setSemester))
        toolBar.setItems([cancel,flexSpace,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        selectSemesterTextField.inputAccessoryView = toolBar
        toolBar.tintColor = .mainColor
        
    }


}
//MARK:- extension 부분


extension Day2SelectTimeViewController : UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return 12
        }
        else
        {
            return 12
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return semesterList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }

        
    
    
}
