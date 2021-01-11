//
//  DrawingViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2020/12/29.
//

import UIKit

class Day3DrawingViewController: UIViewController {

    //MARK:- IBOutlet Part
    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용
    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!
    
    @IBOutlet weak var handBackgroundImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    
    //MARK:- Variable Part
    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용
    /// ex)  var imageViewList : [UIImageView] = []
    
    var drawIndex = 0
    
    var brushColor = UIColor.red
    var brushWidth: CGFloat = 10.0
    var lastPoint = CGPoint.zero
    var isDrawing = false
    var isLinked = [false, false]
    var left = CGPoint(x: UIScreen.main.bounds.width*0.25,
                       y: UIScreen.main.bounds.height*0.6)
    var right = CGPoint(x: UIScreen.main.bounds.width*0.85,
                        y: UIScreen.main.bounds.height*0.6)

    
    


    
    //MARK:- Constraint Part
    /// 스토리보드에 있는 layout 에 대한 @IBOutlet 을 선언합니다. (Height, Leading, Trailing 등등..)  // 변수명 lowerCamelCase 사용
    /// ex) @IBOutlet weak var lastImageBottomConstraint: NSLayoutConstraint!
    
    
    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        print("꺄악",UIScreen.main.bounds.width)
        isDrawing = true
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        headerView.backgroundColor = .clear
        linkLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)

        
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("endDrawing"), object: nil)
    }
    
    
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    
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
    ///
    ///그림판 함수 구현
    func drawLine(from: CGPoint, to: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(handBackgroundImage.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        handBackgroundImage.image?.draw(in: handBackgroundImage.bounds)
        
        // 2
        context.setLineWidth(brushWidth)
        context.setStrokeColor(.init(red: 171/255, green: 112/255, blue: 245/255, alpha: 1))
       
        // 3
        context.move(to: from)
        context.addLine(to: to)
        
        // 4
        context.strokePath()
        
        // 5
        handBackgroundImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
    }

    // 그림 그리기 시작
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        
        print("TOUCHBAGAN")
        if let touch = touches.first {
            lastPoint = touch.location(in: handBackgroundImage)
//            print(touch.location(in: canvasImageView))
        }
    }
    
    // 그림 그리는 중
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        
        print("TOUCHBAGddddddAN")
        isDrawing = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: handBackgroundImage)
            drawLine(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
            print(touch.location(in: handBackgroundImage))
            print("left",left, "right",right)
            
            
            //왼쪽 좌표 범위 터치
            
            if (left.x-30 < lastPoint.x && touch.location(in: handBackgroundImage).x < left.x+30) &&
                (left.y-30 < lastPoint.y && touch.location(in: handBackgroundImage).y < left.y+30) {
                
                isLinked[0] = true
                print("왼쪽이어짐",isLinked)
                
            }
            
            //오른쪽 좌표 범위 터치
            if (right.x-30 < lastPoint.x && touch.location(in: handBackgroundImage).x < right.x+30) &&
                (right.y-30 < lastPoint.y && touch.location(in: handBackgroundImage).y < right.y+30) {
            
                isLinked[1] = true
                print("오른쪽 이어짐",isLinked)
                
                
                
            }
            
            if isLinked[0] && isLinked[1] {
                print("둘다 True",isLinked)
                
                //이어진 사진으로 변경되는 코드
                UIView.animate(withDuration: 5 , animations: {
                  
                    self.view.layoutIfNeeded()
                    self.handBackgroundImage.image = UIImage(named: "handDrawingComplete")

                }, completion: { (_) in
                    
          
                    self.dismiss(animated: true) {
         
                    }
                    
            
                    
                    
                }
                
                
//
//                , completion: {_ in
//                    self.dismiss(animated: true) {
//                        noti
//                        aponimousmeesage
//                        Index.path
//
//
//
//
//                    }
//
//                }
//
                )
                
            }
        }
    }
    
    
    
    // 그림 끝
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDrawing {
            drawLine(from: lastPoint, to: lastPoint)
            
            
        }
        isDrawing = false
    }
    
//    override func linkleft(_ int: ) -> Void{
//        if lastPoint =
//    }

}


//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }



