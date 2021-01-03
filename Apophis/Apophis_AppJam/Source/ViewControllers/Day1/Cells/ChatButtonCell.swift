//
//  ChatButtonCell.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/03.
//

import UIKit
import MobileCoreServices


class ChatButtonCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ChatFuncButton: UIButton!
    
    var index: Int?
    var funcNum: Int?
    weak var viewController: UIViewController?
    let storyboard = UIStoryboard(name: "Day1", bundle: nil)
    
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진을 저장할 변수
    var captureImage: UIImage!
    // 사진 저장 여부를 나타낼 변수
    var flagImageSave = false
    
    
    @IBAction func ChatButtonAction(_ sender: Any) {
        
        guard let funcNum = funcNum else {return}
        if (funcNum == 1){
            print ("눌리냐?")
            
            let storyboard = UIStoryboard(name: "Day1", bundle: nil)
            
            guard let vc = storyboard.instantiateViewController(identifier: "Day1CompassViewController") as? Day1CompassViewController else  {return}
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            viewController?.present(vc, animated: true, completion: nil)
        }
        else{
            // 카메라를 사용할 수 있다면(카메라의 사용 가능 여부 확인)
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                // 사진 저장 플래그를 true로 설정
                flagImageSave = true
                
                
                // 이미지 피커의 델리케이트 self로 설정
                imagePicker.delegate = self
                // 이미지 피커의 소스 타입을 camera로 설정
                imagePicker.sourceType = .camera
                // 미디어 타입 kUTTypeImage로 설정
                imagePicker.mediaTypes = [kUTTypeImage as String]
                // 편집을 허용하지 않음
                imagePicker.allowsEditing = false
                
                
                // 현재 뷰 컨트롤러를 imagePicker로 대체. 즉 뷰에 imagePicker가 보이게 함
                viewController?.present(imagePicker, animated: true, completion: nil)
            } else {
                // 카메라를 사용할 수 없을 때는 경고창을 나타냄
                myAlert("Camera inaccessable", message: "Application cannot access the camera.")
                print("카메라 안켜진다")
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setChatButton(ImgName: String){
        ChatFuncButton.setTitle("", for: .normal)
        ChatFuncButton.setBackgroundImage(UIImage(named: "\(ImgName)"), for: .normal)
    }
    
    func appendImageViewList(){
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "Day1ViewController") as? Day1ViewController else  {return}
        
        VC.messageList.append(contentsOf: [
                                Day1ChatMessageDataModel(message: "", isLastMessage: false, isMine: false, Day1Func: 5)])
    }
    
    
    
    // 사진, 비디오 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)
        guard let VC = storyboard.instantiateViewController(identifier: "Day1ViewController") as? Day1ViewController else  {return}
        
        // 미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        // 미디어 종류가 사진(Image)일 경우
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            // 사진을 가져와 captureImage에 저장
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave { // flagImageSave가 true이면
                // 사진을 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            VC.pictureImage = captureImage // 가져온 사진을 Day1 뷰컨에 전달
            NotificationCenter.default.post(name: .sendImage, object: nil, userInfo: ["image": captureImage!])

        }
        // 현재의 뷰 컨트롤러를 제거. 즉, 뷰에서 이미지 피커 화면을 제거하여 초기 뷰를 보여줌
        viewController?.dismiss(animated: true, completion: nil)
        appendImageViewList()
        
        let messageList : [Day1ChatMessageDataModel] = VC.messageList
        print(messageList)
    }
    
    // 사진, 비디오 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 현재의 뷰(이미지 피커) 제거
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    // 경고 창 출력 함수
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    static let sendImage = NSNotification.Name("sendImage")
}
