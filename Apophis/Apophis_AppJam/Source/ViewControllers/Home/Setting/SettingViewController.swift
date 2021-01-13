//
//  SettingViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/13.
//

import UIKit

class SettingViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var soundSettingtitleLabel: UILabel!
    @IBOutlet weak var soundSettingLabel: UILabel!
    @IBOutlet weak var contentSoundLabel: UILabel!
    @IBOutlet weak var setAlarmTitleLabel: UILabel!
    @IBOutlet weak var pushSettingLabel: UILabel!
    
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var contentSoundSwitch: UISwitch!
    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    
    //MARK:- Variable Part

    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()

    }
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    
    //MARK:- default Setting Function Part
    func setFont()
    {
        headerTitleLabel.font = .gmarketFont(weight: .Medium, size: 18)
        soundSettingtitleLabel.font = .gmarketFont(weight: .Medium, size: 16)
        setAlarmTitleLabel.font = .gmarketFont(weight: .Medium, size: 16)
        
        soundSettingLabel.font = .gmarketFont(weight: .Medium, size: 14)
        contentSoundLabel.font = .gmarketFont(weight: .Medium, size: 14)
        pushSettingLabel.font = .gmarketFont(weight: .Medium, size: 14)
        
        
    }
    
    //MARK:- Function Part
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func soundSettingClicked(_ sender: Any) {
        
    }
    
    @IBAction func contentSoundSettingClicked(_ sender: Any) {
        
    }
    
    
    
    @IBAction func pushAlarmSettingClicked(_ sender: Any) {
        
    }
    
    
}
//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }
