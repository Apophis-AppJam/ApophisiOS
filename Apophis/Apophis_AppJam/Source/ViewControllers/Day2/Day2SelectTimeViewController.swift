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

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var setTimeTextField: UITextField!
    @IBOutlet weak var circleAnimationView: UIView!
    

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

        createCircularPath(time: 0)
    }


    override func viewWillAppear(_ animated: Bool) {
        setClockView()
        setSegment()
        createPickerView()
        dismissPickerView()
       
    }

    //MARK:- IBAction Part


    //MARK:- default Setting Function Part


    func setClockView()
    {
//        clockView.layer.borderWidth = 1
//        clockView.layer.borderColor = .init(red: 90/255, green: 79/255, blue: 99/255, alpha: 1)
        timeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 24)
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
        pickerView.backgroundColor = .black
        pickerView.tintColor = .white
        
        pickerView.delegate = self
        pickerView.becomeFirstResponder()
        setTimeTextField.inputView = pickerView
        setTimeTextField.textColor = .clear

    }
    
    func createCircularPath(time : Float) {

        
        circleAnimationView.layer.masksToBounds = true
        circleAnimationView.layoutSubviews()
        
        
        let size = (UIScreen.main.bounds.width - 175) / 2
        circleAnimationView.addCircle(size: Float(size), currentTimeValue: time,previousTimeValue: previousTimeValue)


        
        
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

        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(setTime))
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
        
        createCircularPath(time: tempTimeValue)
        
        
        

        
        
        
        
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
    func addCircle(size : Float, currentTimeValue : Float,previousTimeValue : Float){
        
        var speed : Int
  
      
        let temp : Float
        
        var temp1 : Float = currentTimeValue
        var temp2 : Float = previousTimeValue
        
         let circleLayer = CAShapeLayer()
         let progressLayer = CAShapeLayer()
        
        // -.pi / 2
        // 3 * .pi / 2
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: Int(size) + 11, y: Int(size) + 11),
                                        
                                        radius: CGFloat(size),
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2 ,
                                        clockwise: true)
        

        
        
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 1
        circleLayer.strokeColor = UIColor.purple.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.purple.cgColor
        
        
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        
        print("---------------------")
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        print("프리비어스",previousTimeValue)
        print("지금",currentTimeValue)
        
        
        
        circularProgressAnimation.duration = 1

        
        
        if previousTimeValue <= currentTimeValue
        {
            speed = 1
            circularProgressAnimation.fromValue = previousTimeValue
            circularProgressAnimation.toValue = currentTimeValue

        }
        else
        {
            speed = -1
            circularProgressAnimation.fromValue = currentTimeValue
            circularProgressAnimation.toValue = previousTimeValue

        }
        print("지금 스피드",speed)
        

        circularProgressAnimation.speed = Float(speed)
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.byValue = currentTimeValue

        circularProgressAnimation.isRemovedOnCompletion = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")

        
        
        
//
//        let revAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        revAnimation.duration = 5.0
//        revAnimation.toValue = 0.0
//        layer.removeAllAnimations()
//        layer.add(revAnimation, forKey: "strokeEnd")
        
        
  

    }
}
