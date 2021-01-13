//
//  TimerViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/12.
//

import UIKit

class TimerViewController: UINavigationController {
    
    //MARK:- IBOutlet Part

    @IBOutlet weak var apoStoneImageView: UIImageView!
    
    
    @IBOutlet weak var dayDescriptionLabel: UILabel!
    @IBOutlet weak var hourDescriptionLabel: UILabel!
    @IBOutlet weak var minuteDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
    
    @IBOutlet weak var distanceDescriptionLabel: UILabel!
    @IBOutlet weak var distanceCountLabel: UILabel!
    @IBOutlet weak var kmDescriptionLabel: UILabel!
    
  
    
    
    @IBOutlet weak var lineTimerImageView: UIImageView!
    
    
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- IBAction Part

    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- default Setting Function Part
    
    
    func fontSetting()
    {
        dayDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        hourDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        minuteDescriptionLabel.font  = .gmarketFont(weight: .Light, size: 16)
        secondDescriptionLabel.font = .gmarketFont(weight: .Light, size: 16)
        
    }

    //MARK:- Function Part


}
//MARK:- extension 부분
