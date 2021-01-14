//
//  IntroBeginViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/14.
//

import UIKit

class IntroBeginViewController: UIViewController {

    //MARK:- IBOutlet Part

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel2: UILabel!
    //MARK:- Variable Part
    

    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()

    }
    
    //MARK:- IBAction Part
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        guard let homeVC = storyboard.instantiateViewController(identifier: "HomeNavigationController") as? HomeNavigationController else {return}
        
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    //MARK:- default Setting Function Part

    func setFont()
    {
        titleLabel.font = .gmarketFont(weight: .Medium, size: 12)
        
        descriptionLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        descriptionLabel2.font = .gmarketFont(weight: .Medium, size: 14)
    }
    
    //MARK:- Function Part


}
//MARK:- extension 부분

