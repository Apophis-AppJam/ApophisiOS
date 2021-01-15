//
//  Day3ColorViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2021/01/12.
//

import UIKit

class Day3ColorViewController: UIViewController {
    
    //MARK:- IBOutlet Part
    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용
    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!
    
    @IBOutlet weak var colorListCollectionView: UICollectionView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var selectedColorImage: UIImageView!
    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    

    //MARK:- Variable Part
    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용
    /// ex)  var imageViewList : [UIImageView] = []
    let colorArray: [UIColor] = [
        .init(red: 207/255, green: 43/255, blue: 30/255, alpha: 1),
        .init(red: 220/255, green: 138/255, blue: 57/255, alpha: 1),
        .init(red: 238/255, green: 208/255, blue: 68/255, alpha: 1),
        .init(red: 163/255, green: 194/255, blue: 70/255, alpha: 1),
        .init(red: 57/255, green: 119/255, blue: 7/255, alpha: 1),
        .init(red: 24/255, green: 115/255, blue: 10/255, alpha: 1),
        .init(red: 23/255, green: 80/255, blue: 175/255, alpha: 1),
        .init(red: 77/255, green: 134/255, blue: 244/255, alpha: 1),
        .init(red: 129/255, green: 177/255, blue: 236/255, alpha: 1),
        .init(red: 171/255, green: 81/255, blue: 161/255, alpha: 1),
        .init(red: 244/255, green: 141/255, blue: 179/255, alpha: 1),
        .init(red: 123/255, green: 41/255, blue: 120/255, alpha: 1),
        .init(red: 71/255, green: 71/255, blue: 71/255, alpha: 1),
        .init(red: 186/255, green: 186/255, blue: 186/255, alpha: 1),
        .init(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)]

    
    var checkedList : [Bool] = []

    
    //MARK:- Constraint Part
    /// 스토리보드에 있는 layout 에 대한 @IBOutlet 을 선언합니다. (Height, Leading, Trailing 등등..)  // 변수명 lowerCamelCase 사용
    /// ex) @IBOutlet weak var lastImageBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for i in 0...15
        {
            checkedList.append(false)
        }
        
        addObserver()
        
        // 헤더 타이틀 폰트 설정
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 16)
        colorListCollectionView.dataSource = self
        colorListCollectionView.delegate = self
        colorListCollectionView.backgroundColor = .none
        ColorLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        completeLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        ColorLabel.alpha = 0
        completeButton.isEnabled = false
        
    }
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    @IBAction func completeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("colorPickerComplete"), object: nil)
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
    func addObserver()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorChecked), name: NSNotification.Name("colorChecked"), object: nil)
        
    
    }


//MARK:- @objc func 부분


@objc func colorChecked(notification : NSNotification)
{
    ColorLabel.alpha = 1
    
    completeButton.isEnabled = true
    completeButton.setBackgroundImage(UIImage(named: "btn_complete_act"), for: .normal)
    
    let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
    
    let index = notification.object as? Int ?? -1
    
    for i in 0...15
    {
        checkedList[i] = false
    }
    
    checkedList[index] = true
    
    colorListCollectionView.reloadData()
    
    switch (index){
    
    
    case 0:
        
        selectedColorImage.image = UIImage(named: "imgRed")
        ColorLabel.text = "빨간색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "빨간색"))
        
        ColorLabel.attributedText = attributedString

        
        
        
        
    case 1:
        
        selectedColorImage.image = UIImage(named: "imgOrange")
        ColorLabel.text = "주황색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "주황색"))
        
        ColorLabel.attributedText = attributedString
        
    case 2:
        
        selectedColorImage.image = UIImage(named: "imgYellow")
        ColorLabel.text = "노란색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "노란색"))
        ColorLabel.attributedText = attributedString
        
    case 3:
        
        selectedColorImage.image = UIImage(named: "imgYellowgreen")
        ColorLabel.text = "연두색이 떠올라"
        
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)

        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "연두색"))
        ColorLabel.attributedText = attributedString
        
    case 4:
        
        selectedColorImage.image = UIImage(named: "imgOlive")
        ColorLabel.text = "연초록색이 떠올라"
        
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "연초록색"))
        ColorLabel.attributedText = attributedString
        
    case 5:
        
        selectedColorImage.image = UIImage(named: "imgGreen")
        ColorLabel.text = "초록색이 떠올라"
        
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "초록색"))
        ColorLabel.attributedText = attributedString
        
    case 6:
        
        selectedColorImage.image = UIImage(named: "imgNavy")
        ColorLabel.text = "남색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "남색"))
        ColorLabel.attributedText = attributedString
        
    case 7:
        
        selectedColorImage.image = UIImage(named: "imgBlue")
        ColorLabel.text = "파란색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "파란색"))
        ColorLabel.attributedText = attributedString
        
    case 8:
        
        selectedColorImage.image = UIImage(named: "imgGreyblue")
        ColorLabel.text = "하늘색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "하늘색"))
        ColorLabel.attributedText = attributedString
        
    case 9:
        
        selectedColorImage.image = UIImage(named: "imgDarkpink")
        ColorLabel.text = "자주색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "자주색"))
        ColorLabel.attributedText = attributedString
        
    case 10:
        
        selectedColorImage.image = UIImage(named: "imgPink")
        ColorLabel.text = "분홍색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "분홍색"))
        ColorLabel.attributedText = attributedString
        
    case 11:
        
        selectedColorImage.image = UIImage(named: "imgPurple")
        ColorLabel.text = "보라색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "보라색"))
        ColorLabel.attributedText = attributedString
        
    case 12:
        
        selectedColorImage.image = UIImage(named: "imgBlack")
        ColorLabel.text = "검은색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "검은색"))
        ColorLabel.attributedText = attributedString
        
        
    case 13:
        
        selectedColorImage.image = UIImage(named: "imgGrey")
        ColorLabel.text = "회색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "회색"))
        ColorLabel.attributedText = attributedString
        
    case 14:
        
        selectedColorImage.image = UIImage(named: "imgWhite")
        ColorLabel.text = "흰색이 떠올라"
        
        let attributedString = NSMutableAttributedString(string: ColorLabel.text!)
        
        attributedString.addAttribute(.foregroundColor, value: colorArray[index], range: (ColorLabel.text! as NSString).range(of: "흰색"))
        ColorLabel.attributedText = attributedString
        
    default :
    
        print("에러?")
        
    }
    
    
    
}
    
}

//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }



extension Day3ColorViewController: UICollectionViewDelegate{

}

extension Day3ColorViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Day3ColorListcell", for: indexPath) as! Day3ColorListcell
        
        cell.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 21
        cell.setCheck(isChekced: checkedList[indexPath.row])
        
         return cell
    }
    
    
}

extension Day3ColorViewController: UICollectionViewDelegateFlowLayout {

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
//
//        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
//        print("collectionView width=\(collectionView.frame.width)")
//        print("cell하나당 width=\(width)")
//        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: 42, height: 42)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
    }
}

