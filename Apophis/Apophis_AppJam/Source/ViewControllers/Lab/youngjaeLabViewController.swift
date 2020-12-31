//
//  youngjaeLabViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/30.
//

import UIKit

class youngjaeLabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

    
    }
    
    @IBAction func compassButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day1CompassViewController") as? Day1CompassViewController else  {return}
        
        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day1CameraViewController") as? Day1CameraViewController else  {return}
        
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
}
