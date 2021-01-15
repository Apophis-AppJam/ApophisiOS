//
//  SplashViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import UIKit
import Lottie
import AVFoundation


var soundEffect: AVAudioPlayer?

class SplashViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    @IBOutlet weak var splashView: UIView!
    
    //MARK:- Variable Part

    var loadingView = AnimationView()
    
    //MARK:- Constraint Part

    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
        
        
        
        let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            if UserDefaults.standard.bool(forKey: "isOnboardingComplete") == false
            {
     

                self.goToNews()
                UserDefaults.standard.setValue(true, forKey: "isOnboardingComplete")
                UserDefaults.standard.setValue(true, forKey: "isFirstHome")
            }
            else
            {
                self.goToHome()
            }
  
            
            
        }
        
    }
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    
    //MARK:- default Setting Function Part
    
    
    
    //MARK:- Function Part
    func play()
    {
        
        loadingView = AnimationView()
        loadingView.frame = splashView.bounds
        loadingView.animation = Animation.named("apophis_splash")
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.play()


        splashView.addSubview(loadingView)
        
        
    }
    
    func goToNews()
    {
        
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        guard let newsVC = storyboard.instantiateViewController(identifier: "IntroNavigationController") as? IntroNavigationController else {return}
        
        newsVC.modalPresentationStyle = .fullScreen
        newsVC.modalTransitionStyle = .crossDissolve
        self.present(newsVC, animated: true, completion: nil)

    }
    
    func goToLoginView()
    {
        
    }
    
    
    
    func goToHome()
    {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        guard let homeVC = storyboard.instantiateViewController(identifier: "HomeNavigationController") as? HomeNavigationController else {return}
        
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
    
    func goToLabs()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let labVC = storyboard.instantiateViewController(identifier: "LabNavigationController") as? LabNavigationController else {return}
        
        labVC.modalPresentationStyle = .fullScreen
        labVC.modalTransitionStyle = .crossDissolve
        self.present(labVC, animated: true, completion: nil)
    }

}
//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }

