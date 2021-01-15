//
//  Day6EraseViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2021/01/15.
//

import UIKit

class Day6EraseViewController: UIViewController {

    
    //MARK:- IBOutlet Part
    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용
    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!
//`    @IBOutlet weak var eraseImageView1: UIImageView!
//`    @IBOutlet weak var eraseImageView2: UIImageView!
//`    @IBOutlet weak var eraseImageView3: UIImageView!
//`    @IBOutlet weak var eraseImageView4: UIImageView!
//`    @IBOutlet weak var eraseImageView5: UIImageView!
    @IBOutlet weak var eraserButton1: UIButton!
    @IBOutlet weak var eraserButton2: UIButton!
    @IBOutlet weak var eraserButton3: UIButton!
    @IBOutlet weak var eraserButton4: UIButton!
    @IBOutlet weak var eraserLabel1: UILabel!
    @IBOutlet weak var eraserLabel2: UILabel!
    @IBOutlet weak var eraserLabel3: UILabel!
    @IBOutlet weak var eraserLabel4: UILabel!
    @IBOutlet weak var eraserLabel5: UILabel!
    @IBOutlet weak var eraseComplteButton: UIButton!
    
    
    

    //MARK:- Variable Part
    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용
    /// ex)  var imageViewList : [UIImageView] = []
    
    //MARK:- Constraint Part
    /// 스토리보드에 있는 layout 에 대한 @IBOutlet 을 선언합니다. (Height, Leading, Trailing 등등..)  // 변수명 lowerCamelCase 사용
    /// ex) @IBOutlet weak var lastImageBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eraserLabel1.font = .gmarketFont(weight: .Medium, size: 14)
        eraserLabel2.font = .gmarketFont(weight: .Medium, size: 14)
        eraserLabel3.font = .gmarketFont(weight: .Medium, size: 14)
        eraserLabel4.font = .gmarketFont(weight: .Medium, size: 14)
        eraserLabel5.font = .gmarketFont(weight: .Medium, size: 14)
        
        eraserLabel1.alpha = 1
        eraserLabel2.alpha = 0
        eraserLabel3.alpha = 0
        eraserLabel4.alpha = 0
        eraserLabel5.alpha = 0
        
        eraseComplteButton.alpha = 0
        
    }
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    @IBAction func clickedButton1(_ sender: Any) {
        
     
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState) {


            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2.0/3.0,animations: {

                self.eraserButton1.alpha = 0
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel1.alpha = 0
                
            })

            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel2.alpha = 1
                
            })
            
        } completion: {_ in self.eraserButton1.isHidden = true
    }
            
}
    
    @IBAction func clickedButton2(_ sender: Any) {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState) {


            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2.0/3.0,animations: {

                self.eraserButton2.alpha = 0
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel2.alpha = 0
                
            })

            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel3.alpha = 1
                
            })
            
        } completion: {_ in self.eraserButton2.isHidden = true
    }
        
        
    }
        
    
    @IBAction func clickedButton3(_ sender: Any) {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState) {


            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2.0/3.0,animations: {

                self.eraserButton3.alpha = 0
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel3.alpha = 0
                
            })

            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel4.alpha = 1
                
            })
            
        } completion: {_ in self.eraserButton3.isHidden = true
    }

    }
        
    
    @IBAction func clickedButton4(_ sender: Any) {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState) {


            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2.0/3.0,animations: {

                self.eraserButton4.alpha = 0
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel4.alpha = 0
                
            })

            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1.0/3.0,animations: {

                self.eraserLabel5.alpha = 1
                self.eraseComplteButton.alpha = 1
                
            })
            
        } completion: {_ in self.eraserButton4.isHidden = true
    }
        

    }
        
    
    @IBAction func eraseCompleteButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("eraseComplete"), object: nil)
        }
    }
    
        
    //MARK:- default Setting Function Part
    /// 기본적인 세팅을 위한 함수 부분입니다 // 함수명 lowerCamelCase 사용
    /// ex) func tableViewSetting() {
    ///         myTableView.delegate = self
    ///         myTableView.datasource = self
    ///    }
    
    //MARK:- Function Part
    /// 로직을 구현 하는 함수 부분입니다. // 함수명 lowerCamelCase 사용
    /// ex) func tableViewSetting() {
    ///         myTableView.delegate = self
    ///         myTableView.datasource = self
    ///    }

    }

//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }

