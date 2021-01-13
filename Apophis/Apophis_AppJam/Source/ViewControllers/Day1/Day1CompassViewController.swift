//
//  Day1CompassViewController.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2020/12/31.
//

import UIKit
import CoreLocation

class Day1CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    
    //MARK:- IBOutlet Part

    @IBOutlet weak var compassBackground: UIImageView!
    @IBOutlet weak var compassBackBtn: UIButton!
    @IBOutlet weak var imgCompassArrow: UIImageView!
    @IBOutlet weak var imgCompass: UIImageView!
    
    
    //MARK:- Variable Part
    
    var index : Int = 0
    
    // 나침반을 위한 변수
    let east = 90
    var locManager = CLLocationManager()
    
    // 타이머를 위한 변수
    var timer = Timer()
    var startTimer = false
    
    
    
    //MARK:- Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSet()
        compassSet()
        
    }
    
    //MARK:- IBAction Part
    
    
    @IBAction func compassBackBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- default Setting Function Part

    func viewSet(){
        compassBackBtn.setTitle("", for: .normal)
        compassBackground.image = UIImage(named: "bgCompass")
        compassBackBtn.setBackgroundImage(UIImage(named: "slice2"), for: .normal)
        imgCompassArrow.image = UIImage(named: "imgCompassArrow")
        imgCompassArrow.alpha = 0.4
        imgCompass.image = UIImage(named: "imgCompass")
    }
    
    
    func compassSet(){
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        // 기기가 세로모드인걸 기준으로한다. 위쪽이 바라보는 방향을 쓰겠다는 것.
        locManager.headingOrientation = .portrait
        // 새 방향 이벤트를 생성하는 데 필요한 최소 각도를 설정해주는 것.
        // 각도 거리는 마지막으로 전달 된 방향 이벤트를 기준으로 측정됩니다. 모든 움직임에 대한 알림을 받기위해서는 kCLHeadingFilterNone 값을 사용해야한다.
        locManager.headingFilter = kCLHeadingFilterNone
        locManager.delegate = self
        
        // 사용자의 위치와 방향을 즉각적으로 업데이트 해주는 메소드
        locManager.startUpdatingLocation()
        locManager.startUpdatingHeading()
    }
    
    
    
    
    // MARK:- Function Part
    // 나침반 관련 CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed: \(error)")
    }
    
    
    // 정확히는 모르겠는데, heading 값은 시스템이 보정을 하기 전까지는 값이 부정확할 수 있다고 함. 그래서 그 값을 iOS가 보정할 수 있도록 하는 함수라고 한다.
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    
    
    // heading 값이 업데이트 될 때마다 호출되는 함수!
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = Int(newHeading.magneticHeading)
        print("heading : ", heading)
        
        
        // iOS는 각도를 계산할 때 0~360의 degree가 아닌 radian을 사용한다. 그래서 우리가 받아온 degree 값을 radian으로 변환해주어야한다.
        // degree to radian 변환식은  'number * .pi /180'
        // 처음에는 감으로  '-CGFloat(heading)/57.2' 무식하게 값을 때려박으면서 위와 같은 코드를 써주었는데, 57.2가 radian 값이랑 비슷해서 얼추 맞았던 듯. 하지만  radian으로 변환을 해주어야 359에서 0을 넘어갈때 훨씬 부드럽고 자연스럽게 애니메이션이 이어진다.
        UIView.animate(withDuration: 0.2, animations: {
            self.imgCompass.transform = CGAffineTransform(rotationAngle: -CGFloat(heading) * .pi / 180)
        })
        
        // 정확히 동쪽(90)을 맞추는건 가능하지만, 그걸 계속 유지하는게 생각보다 쉽지 않다. 그래서 95에서 85사이로 범위에 여유를 줬다.
        if (heading <= east+5 && heading >= east-5){
            imgCompassArrow.alpha = 1
            
            // timer가 시작되지 않은 상태라면 타이머를 시작한다
            if(startTimer == false){
                startTimer = true
                timeLimitStart()}
            
        } else {
            imgCompassArrow.alpha = 0.4
            // 범위를 벗어나면 해당 함수를 사용하여 타이머를 리셋 시킨다.
            timeLimitStop()
        }
        
    }
    
    // 타이머가 시작된다면 2초 뒤에 timeLimit()을 실행한다
    func timeLimitStart(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Day1CompassViewController.timeLimit), userInfo: nil, repeats: false)
    }
    
    // 타이머를 리셋시켜주는 함수
    func timeLimitStop(){
        startTimer = false
        timer.invalidate()
    }
    
    // 2초동안 범위를 유지한 경우에는 더 이상 나침반이 돌아가지 않게 만든다.
    // 방향 체크가 끝나음을 사용자에게 티내기 위해 나침반 이미지를 동쪽으로 고정시켜버린다.
    @objc func timeLimit(){
        locManager.stopUpdatingLocation()
        locManager.stopUpdatingHeading()
        UIView.animate(withDuration: 0, animations: {
            self.imgCompass.transform = CGAffineTransform(rotationAngle: -.pi/2)
        })
        
        
        NotificationCenter.default.post(name: NSNotification.Name("compassComplete"), object: index)

        dismiss(animated: true, completion: nil)

    }
    
    
    
    
}
