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


        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            

            
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            
            
            
//            if self.commentCount == self.newsCommentTempList.count // temp 배열 떨어질때까지 하나씩 추가해봅시다
//            {
//                timer.invalidate()
//            }
            

        }
        
    }
    
    //MARK:- IBAction Part

    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part


}
//MARK:- extension 부분
