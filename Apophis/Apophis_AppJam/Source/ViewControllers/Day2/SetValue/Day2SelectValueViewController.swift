//
//  Day2SelectValueViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/11.
//

import UIKit

class Day2SelectValueViewController: UIViewController {
    
    //MARK:- IBOutlet Part
    
    
    @IBOutlet weak var firstCircleView: RoundedUIView!
    @IBOutlet weak var secondCircleView: RoundedUIView!
    @IBOutlet weak var thirdCircleView: RoundedUIView!
    @IBOutlet weak var fourthCircleView: RoundedUIView!
    @IBOutlet weak var fifthCircleView: RoundedUIView!
    @IBOutlet weak var sixthCircleView: RoundedUIView!
    
    
    
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var remainCountLabel: UILabel!
    
    
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var firstCountLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    
    
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var secondCountLabel: UILabel!
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var thirdDescriptionLabel: UILabel!
    @IBOutlet weak var thirdCountLabel: UILabel!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    
    @IBOutlet weak var fourthDescriptionLabel: UILabel!
    @IBOutlet weak var fourthCountLabel: UILabel!
    @IBOutlet weak var fourthImageView: UIImageView!
    
    
    @IBOutlet weak var fifthDescriptionLabel: UILabel!
    @IBOutlet weak var fifthCountLabel: UILabel!
    @IBOutlet weak var fifthImageView: UIImageView!
    
    @IBOutlet weak var sixthDescriptionLabel: UILabel!
    @IBOutlet weak var sixthCountLabel: UILabel!
    @IBOutlet weak var sixthImageView: UIImageView!
    

    @IBOutlet weak var nextButton: UIButton!
    
    
    //MARK:- Variable Part
    
    var remainCount = 10
    
    var countList : [Int] = [0,0,0,0,0,0]
    
    var confirmList : String = ""

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
        setBorder()
        enableButton(enable: false)
    }
    
    //MARK:- IBAction Part
    
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        
        remainCount = 10
        
        countList[0] = 0
        countList[1] = 0
        countList[2] = 0
        countList[3] = 0
        countList[4] = 0
        countList[5] = 0
        
        firstImageView.image = UIImage()
        secondImageView.image  = UIImage()
        thirdImageView.image  = UIImage()
        fourthImageView.image  = UIImage()
        fifthImageView.image  = UIImage()
        sixthImageView.image  = UIImage()
        
        remainCountLabel.text = String(remainCount)
        
        firstCountLabel.text = String(0)
        secondCountLabel.text = String(0)
        thirdCountLabel.text = String(0)
        fourthCountLabel.text = String(0)
        fifthCountLabel.text = String(0)
        sixthCountLabel.text = String(0)
        
        confirmList = ""
        
        
    }
    
    
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        if remainCount > 0
        {
            countList[0] = countList[0] + 1
            firstCountLabel.text = String(countList[0]) + "개"
            firstImageView.image = imageInCount(count: countList[0])
            
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
            
            
            
        }
    }
    
    
    @IBAction func secondButtonClicked(_ sender: Any) {
        
        if remainCount > 0
        {
            countList[1] = countList[1] + 1
            secondCountLabel.text = String(countList[1]) + "개"
            secondImageView.image = imageInCount(count: countList[1])
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
        }
    }
    
    
    
    @IBAction func thirdButtonClicked(_ sender: Any) {
        
        if remainCount > 0
        {
            countList[2] = countList[2] + 1
            thirdCountLabel.text = String(countList[2]) + "개"
            thirdImageView.image = imageInCount(count: countList[2])
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
        }
        

    }
    
    
    
    @IBAction func fourthButtonClicked(_ sender: Any) {
        if remainCount > 0
        {
            countList[3] = countList[3] + 1
            fourthCountLabel.text = String(countList[3]) + "개"
            fourthImageView.image = imageInCount(count: countList[3])
            
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
        }

    }
    
    
    @IBAction func fifthBUttonClicked(_ sender: Any) {
        if remainCount > 0
        {
            countList[4] = countList[4] + 1
            fifthCountLabel.text = String(countList[4]) + "개"
            fifthImageView.image = imageInCount(count: countList[4])
            
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
        }

    }
    
    
    @IBAction func sixthButtonClicked(_ sender: Any) {
        if remainCount > 0
        {
            countList[5] = countList[5] + 1
            sixthCountLabel.text = String(countList[5]) + "개"
            sixthImageView.image = imageInCount(count: countList[5])
            
            remainCount = remainCount - 1
            
            if remainCount == 0
            {
                enableButton(enable: true)
            }
            else
            {
                enableButton(enable: false)
            }
            
            remainCountLabel.text = String(remainCount)
            
        }

    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        guard let confirmVC = self.storyboard?.instantiateViewController(identifier: "Day2ConfirmValueViewController") as? Day2ConfirmValueViewController else {return}
        
        
        
        
    
        
        confirmVC.confirmList = makeConfirmList()
        
        self.navigationController?.pushViewController(confirmVC, animated: true)
        
        

    }
    
    
    //MARK:- default Setting Function Part
    
    
    func setBorder()
    {
        
        firstCircleView.layer.borderWidth = 1
        firstCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        secondCircleView.layer.borderWidth = 1
        secondCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        thirdCircleView.layer.borderWidth = 1
        thirdCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
        fourthCircleView.layer.borderWidth = 1
        fourthCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        fifthCircleView.layer.borderWidth = 1
        fifthCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
        sixthCircleView.layer.borderWidth = 1
        sixthCircleView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
        
    }
    
    func setFont()
    {
        

        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 16)
        descriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        remainCountLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        
        firstDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        firstCountLabel.font = .gmarketFont(weight: .Medium, size: 14)

        
        secondDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        secondCountLabel.font = .gmarketFont(weight: .Medium, size: 14)

        
        thirdDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        thirdCountLabel.font = .gmarketFont(weight: .Medium, size: 14)
    
        fourthDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        fourthCountLabel.font = .gmarketFont(weight: .Medium, size: 14)
    
        fifthDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        fifthCountLabel.font = .gmarketFont(weight: .Medium, size: 14)
    
        
        sixthDescriptionLabel.font = .gmarketFont(weight: .Medium, size: 16)
        sixthCountLabel.font = .gmarketFont(weight: .Medium, size: 14)

   
    }
    
    
    func enableButton(enable : Bool)
    {
        if enable
        {
            nextButton.isEnabled = true
            nextButton.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        }
        else
        {
            nextButton.isEnabled = false
            nextButton.setBackgroundImage(UIImage(named: "nextBtnUnactivated"), for: .normal)
        }
    }
    
    
    //MARK:- Function Part

    func makeConfirmList() -> String
    {
        var maxCount = 0
        var resultList = ""
        var isFirst = true
        
        for i in 0 ... countList.count - 1
        {
            maxCount = max(countList[i], maxCount)
        }

    
        for i in 0 ... countList.count - 1
        {
            if countList[i] == maxCount
            {
                if isFirst
                {
                    resultList += listForTitle(index: i)
                    isFirst = false
                }
                else
                {
                    resultList += "\n" + listForTitle(index: i)
                }
            }
            

        }
        
        return resultList
        
        
    }
    
    func listForTitle(index : Int) -> String
    {
        switch(index)
        {
        case 0 : return "사랑"
        case 1 : return "관계"
        case 2 : return "성취"
        case 3 : return "만족"
        case 4 : return "즐거움"
        case 5 : return "안정"
        default : return ""
            
        }
    }
    
    func imageInCount(count : Int) -> UIImage
    {
        switch(count)
        {
            case 0 : return UIImage()
            case 1 : return UIImage(named: "imgValue1")!
            case 2 : return UIImage(named: "imgValue2")!
            case 3 : return UIImage(named: "imgValue3")!
            case 4 : return UIImage(named: "imgValue4")!
            case 5 : return UIImage(named: "imgValue5")!
            case 6 : return UIImage(named: "imgValue6")!
            case 7 : return UIImage(named: "imgValue7")!
            case 8 : return UIImage(named: "imgValue8")!
            case 9 : return UIImage(named: "imgValue9")!
            case 10 : return UIImage(named: "imgValue10")!
            default : return UIImage()
        }
    }
    

}
//MARK:- extension 부분

