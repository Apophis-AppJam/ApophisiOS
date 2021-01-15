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
    @IBOutlet weak var descriptionLabel3: UILabel!
    
    
    @IBOutlet weak var startButton: UIButton!
    //MARK:- Variable Part
    

    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        setFont()
        showText()

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
        descriptionLabel3.font = .gmarketFont(weight: .Medium, size: 14)
    }
    
    func showText()
    
    {
        
        titleLabel.alpha = 0
        descriptionLabel.alpha = 0
        descriptionLabel2.alpha = 0
        descriptionLabel3.alpha = 0
        startButton.alpha = 0
        startButton.isEnabled = false
        
        
        
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: .allowUserInteraction) {

            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3,animations: {
                    self.titleLabel.alpha = 1
                    
                })
                
            UIView.addKeyframe(withRelativeStartTime: 1/8, relativeDuration: 1/3, animations: {
                
                self.descriptionLabel.alpha = 1
                self.descriptionLabel2.alpha = 1
                self.descriptionLabel3.alpha = 1
                                        
                })
            
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    self.startButton.alpha = 1
           
                })
            
        } completion: { (_) in
            self.startButton.isEnabled = true
        }
    }
    
    //MARK:- Function Part


}
//MARK:- extension 부분

