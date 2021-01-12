//
//  Day2ConfirmValueViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/11.
//

import UIKit

class Day2ConfirmValueViewController: UIViewController {
    
    //MARK:- IBOutlet Part

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    
    
    //MARK:- Variable Part

    
    var confirmList : String = ""
    var result = ""
    
    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFont()
        confirmLabel.text = confirmList
    }
    
    //MARK:- IBAction Part

    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func confirmButtonClicked(_ sender: Any) {


        print("순서@@@",result)
        makeResult { (completion) in
            if completion
            {
                print("AAAAAAAAAAA",self.result)
                self.dismiss(animated: true) {
                    
                    print("DDDDDDDDDDDD",self.result)
                    NotificationCenter.default.post(name: NSNotification.Name("valueSelectComplete"), object: self.result)
                    print("CCCCCCCCCCCC",self.result)
                }
            }
        }
        

    }
    
    
    //MARK:- default Setting Function Part
    
    func makeResult(completion: @escaping (Bool) -> Void)
    {
        
        let valueList = confirmList.components(separatedBy: "\n")
        result = "나는 "
        var resultList : [Int] = []
        
        
        if valueList.count > 0
        {
            for i in 0 ... valueList.count - 1
            {
                resultList.append(i)
                if i == 0
                {
                    result += valueList[i]
                }
                else
                {
                    result += "," + valueList[i]
                }
            }
            
        }

        
        // 사랑 관계 성취 만족 즐거움 안정이라는 단어인데 뒤에 어미 처리해야함
        if valueList.count > 0
        {
            if valueList.last == "성취" || valueList.last == "관계"
            {
                result += "를 "
            }
            else
            {
                result += "을 "
            }
        }
        
        result += "가장 중요하게 생각하는 사람인 것 같아."
        print("GGGGGGGGG",result)
        completion(true)
        
    }
    
    func setFont()
    {
        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 16)
        descriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        confirmLabel.font = .gmarketFont(weight: .Medium, size: 24)
        
        completeLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        
    }

    //MARK:- Function Part

}
//MARK:- extension 부분
