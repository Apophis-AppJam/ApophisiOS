//
//  HomeViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/09.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- IBOutlet Part

    

    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- IBAction Part

    
    
    @IBAction func apophisTimerButtonClicked(_ sender: Any) {
        
        
        guard let timerVC = self.storyboard?.instantiateViewController(identifier: "TimerViewController") as? TimerViewController else {return}
        
        
        self.navigationController?.pushViewController(timerVC, animated: true)
        
    }
    
    
    @IBAction func phoneButtonClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        
        
        
        guard let timerVC = self.storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        
        
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
    
    
    @IBAction func bucketListButtonClicked(_ sender: Any) {
        
        guard let bucketVC = self.storyboard?.instantiateViewController(identifier: "BucketListViewController") as? BucketListViewController else {return}
        
        self.navigationController?.pushViewController(bucketVC, animated: true)
        
    }
    
    
    
    @IBAction func letterButtonClicked(_ sender: Any) {
        
        guard let letterVC = self.storyboard?.instantiateViewController(identifier: "LetterViewController") as? LetterViewController else {return}
        
        self.navigationController?.pushViewController(letterVC, animated: true)
        
    }
    
    
    //MARK:- default Setting Function Part

    
    //MARK:- Function Part

}
//MARK:- extension 부분
