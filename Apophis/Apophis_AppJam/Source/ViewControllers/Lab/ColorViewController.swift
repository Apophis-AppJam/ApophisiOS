//
//  ColorViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2020/12/31.
//

import UIKit

class ColorViewController: UIViewController {
    @IBOutlet weak var pink: UIButton!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var deepgreen: UIButton!
    @IBOutlet weak var skyblue: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var purple: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pink.layer.cornerRadius = 45
        red.layer.cornerRadius = 45
        orange.layer.cornerRadius = 45
        yellow.layer.cornerRadius = 45
        green.layer.cornerRadius = 45
        deepgreen.layer.cornerRadius = 45
        skyblue.layer.cornerRadius = 45
        blue.layer.cornerRadius = 45
        purple.layer.cornerRadius = 45
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func changePink(_ sender: Any) {
        
        
    }
    
    @IBAction func changeRed(_ sender: Any) {
        
    }
    
    @IBAction func changeOrange(_ sender: Any) {
    }
    
    
    @IBAction func changeYellow(_ sender: Any) {
    }
    
    
    @IBAction func changeGreen(_ sender: Any) {
    }
    
    
    @IBAction func changeDeepGreen(_ sender: Any) {
    }
    
    
    @IBAction func changeSkyblue(_ sender: Any) {
    }
    
    
    @IBAction func changeBlue(_ sender: Any) {
    }
    
    
    @IBAction func changePurple(_ sender: Any) {
    }
}
