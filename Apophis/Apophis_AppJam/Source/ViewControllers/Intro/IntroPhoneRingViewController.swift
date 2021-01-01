//
//  IntroPhoneRingViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/29.
//

import UIKit
import AudioToolbox

class IntroPhoneRingViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    

    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

        // 1초마다 진동을 주게 됨
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in

            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        
    }
    
    //MARK:- IBAction Part

    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part


}
//MARK:- extension 부분
