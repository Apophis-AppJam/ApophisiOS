//
//  Day2SelectTimeViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/01.
//

import UIKit

class Day2SelectTimeViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var AMPMSelectSegment: UISegmentedControl!
    
    //MARK:- Variable Part

    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        setClockView()
        setSegment()
    }
    
    //MARK:- IBAction Part

    
    //MARK:- default Setting Function Part

    
    func setClockView()
    {
        clockView.layer.borderWidth = 1
        clockView.layer.borderColor = .init(red: 90/255, green: 79/255, blue: 99/255, alpha: 1)
    }
    
    func setSegment()
    {
        AMPMSelectSegment.layer.cornerRadius = 12
    }
    
    //MARK:- Function Part


}
//MARK:- extension 부분

