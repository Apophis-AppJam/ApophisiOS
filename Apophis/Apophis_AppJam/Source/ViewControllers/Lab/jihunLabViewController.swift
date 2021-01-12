//
//  jihunLabViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/30.
//

import UIKit

class jihunLabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func phoneButtonClicked(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "IntroPhoneRingViewController") as? IntroPhoneRingViewController else  {return}
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func newsButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "IntroNewsViewController") as? IntroNewsViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    @IBAction func goToClockDay2(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day2SelectTimeViewController") as? Day2SelectTimeViewController else  {return}
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    

    

    @IBAction func goToValue(_ sender: Any) {
        
        
        
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day2SetValueNavigationController") as? Day2SetValueNavigationController else  {return}
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}
