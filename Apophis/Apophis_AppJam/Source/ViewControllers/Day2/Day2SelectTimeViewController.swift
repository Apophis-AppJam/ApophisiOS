//
//  Day2SelectTimeViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/01.
//

import UIKit

class Day2SelectTimeViewController: UIViewController {


    //MARK:- IBOutlet Part

    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var clockView: UIView!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var setTimeTextField: UITextField!
    @IBOutlet weak var circleAnimationView: UIView!
    
    @IBOutlet weak var setTimeLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var completeButtonImageView: UIImageView!
    
    
    
    
    @IBOutlet weak var clockIconImageView: UIImageView!
    
    //MARK:- Variable Part
    
    
    var hourString = "0"
    var minuteString = "00"
    
    var hourValue : Float = 0
    var minuteValue : Float = 0
    var tempTimeValue : Float = 0
    
    
    var previousTimeValue : Float = 0
    

    var hourList : [String] = ["00", "01", "02", "03", "04",
                               "05", "06", "07", "08", "09",
                               "10", "11", "12", "13", "14",
                               "15", "16", "17", "18", "19",
                               "20", "21", "22", "23"]
    var minuteList : [String] = ["00", "01", "02", "03", "04",
                                 "05", "06", "07", "08", "09",
                                 "10", "11", "12", "13", "14",
                                 "15", "16", "17", "18", "19",
                                 "20", "21", "22", "23", "24",
                                 "25", "26", "27", "28", "29",
                                 "30", "31", "32", "33", "34",
                                 "35", "36", "37", "38", "39",
                                 "40", "41", "42", "43", "44",
                                 "45", "46", "47", "48", "49",
                                 "50", "51", "52", "53", "54",
                                 "55", "56", "57", "58", "59"
                                 ]
                                 
                                 
    
    var circularView: CircularProgressView!
    var duration: TimeInterval!
                    

    //MARK:- Constraint Part



    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        createCircularPath(time: 0, isComplete: false)
    }


    override func viewWillAppear(_ animated: Bool) {
        setClockView()

        
        createPickerView()
        dismissPickerView()
       
    }

    //MARK:- IBAction Part

    @IBAction func backButtonClicked(_ sender: Any) {
        
        if (self.navigationController != nil)
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func selectTimeButtonClicked(_ sender: Any) {
        
        
        
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("setTimeComplete"), object: self.timeLabel.text)
            
        }
        
        
        
        
    }
    
    //MARK:- default Setting Function Part


    func setClockView()
    {
        
        headerTitleLabel.font = UIFont.gmarketFont(weight: .Medium, size: 16)
        timeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 24)
        setTimeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        completeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        completeLabel.textColor = .init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        
    }

    //MARK:- Function Part


    func createPickerView()
    {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .init(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        pickerView.tintColor = .white
        
        pickerView.delegate = self
        pickerView.becomeFirstResponder()
        setTimeTextField.inputView = pickerView
        setTimeTextField.textColor = .clear
        
    }
    
    func turnOnCompleteButton()
    {
        
        completeLabel.textColor = .white
        completeButtonImageView.image = UIImage(named: "btn_complete_act")
        
    }
    

    
 
    
    func createCircularPath(time : Float,isComplete : Bool) {

        let size = (UIScreen.main.bounds.width - 175) / 2
      
        circleAnimationView.addCircle(isComplete: isComplete, size: Float(size), currentTimeValue: time,previousTimeValue: previousTimeValue)
        
        
        circleAnimationView.reloadInputViews()
        circleAnimationView.layer.masksToBounds = true
        circleAnimationView.layoutSubviews()
        circleAnimationView.setNeedsLayout()
        


        
        
    }


    func dismissPickerView()
    {
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        
        let normalAttributes : [NSAttributedString.Key: Any] = [
            .font : UIFont.gmarketFont(weight: .Medium, size: 14),
            .foregroundColor : UIColor.white
            ]

        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(done))
        cancel.setTitleTextAttributes(normalAttributes, for: .normal)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(setTime))
        button.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        
        toolBar.setItems([cancel,flexSpace,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        setTimeTextField.inputAccessoryView = toolBar
        toolBar.tintColor = .white

        toolBar.barTintColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
    
        

    }
    
    @objc func done()
    {
        
        
        self.view.endEditing(true)
    }
    @objc func setTime()
    {
        createCircularPath(time: tempTimeValue, isComplete: true)
        turnOnCompleteButton()
        self.view.endEditing(true)
    }
    


}
//MARK:- extension 부분


extension Day2SelectTimeViewController : UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1
        {
            return hourList.count
        }
        else if component == 2
        {
            return minuteList.count
        }
        else
        {
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if component == 1
        {
            return hourList[row]
        }
        else if component == 2
        {
            return minuteList[row]
        }
        else
        {
            return ""
        }
       
    }
    
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        if component == 1
        {
            hourString = hourList[row]
            print("hourRow",Float(row))
            
            hourValue = Float(row) * (1/24)
        
        }
        else if component == 2
        {
            minuteString =  minuteList[row]
            print("minuterow",row)
            minuteValue = Float(row) * (1/1440)

        }
        
        
        
        timeLabel.text = hourString + "시 " + minuteString + "분"
        
        print("지금 값",hourValue + minuteValue)
        
        tempTimeValue = hourValue + minuteValue
        
   
        
        
 
        previousTimeValue = tempTimeValue
        

    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        
 
        
        if component == 1
        {
            
            let normalAttributes : [NSAttributedString.Key: Any] = [
                .font : UIFont.gmarketFont(weight: .Medium, size: 12),
                .foregroundColor : UIColor.white
                ]
            return NSAttributedString(string: hourList[row], attributes: normalAttributes )
        }
        
        else if component == 2
        {
            let normalAttributes : [NSAttributedString.Key: Any] = [
                .font : UIFont.gmarketFont(weight: .Medium, size: 12),
                .foregroundColor : UIColor.white
                ]
            return NSAttributedString(string: minuteList[row], attributes: normalAttributes )
        }
        
        else
        {
            return NSAttributedString()
        }
        

    }




}

extension UIView {
    func addCircle(isComplete: Bool, size : Float, currentTimeValue : Float,previousTimeValue : Float){
        
            

        var speed : Int
  


        let circleLayer = CAShapeLayer()
        var progressLayer = CAShapeLayer()
        
        
        

        
        // -.pi / 2
        // 3 * .pi / 2
        var circularPath = UIBezierPath()
        
        circularPath.removeAllPoints()
        
            
         let path =   UIBezierPath(arcCenter: CGPoint(x: Int(size) + 11, y: Int(size) + 11),
                                        
                                        radius: CGFloat(size),
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2 ,
                                        clockwise: true)
        
        circularPath = path

        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "btn_time_setting")
        imageView.layer.accessibilityPath = path

        
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 1
     
        


        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        
        
        if isComplete == false
        {
            circleLayer.strokeColor = UIColor.init(red: 126/255, green: 126/255, blue: 126/255, alpha: 1).cgColor
            progressLayer.strokeColor = UIColor.init(red: 126/255, green: 126/255, blue: 126/255, alpha: 1).cgColor
        }
        else
        {
            circleLayer.strokeColor = UIColor.init(red: 90/255, green: 79/255, blue: 99/255, alpha: 1).cgColor
            progressLayer.strokeColor = UIColor.mainColor.cgColor
            progressLayer.backgroundColor = UIColor.mainColor.cgColor
            progressLayer.borderColor = UIColor.mainColor.cgColor
            progressLayer.shadowColor = .none
        }

        


        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        layer.addSublayer(imageView.layer)
        
    
        

        
        print("---------------------")

        progressLayer.removeAllAnimations()
        
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")

 
        circularProgressAnimation.duration = 1.5
        
        speed = 1
        

        
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        circularProgressAnimation.fromValue = 0
        circularProgressAnimation.toValue = currentTimeValue
        
        circularProgressAnimation.speed = Float(speed)

        
        
        imageView.layer.add(circularProgressAnimation, forKey: "progressAnim")
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        layer.removeAllAnimations()
        

        

  

    }
}
