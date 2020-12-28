//
//  ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func goToSample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day1ViewController") as? Day1ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func goToDay2Sample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day2ViewController") as? Day2ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func goToDay3Sample(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Day3", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day3ViewController") as? Day3ViewController else  {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

