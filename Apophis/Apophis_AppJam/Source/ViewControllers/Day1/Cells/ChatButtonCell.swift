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
    
    var index: Int = 0
    var funcNum: Int?
    weak var viewController: UIViewController?
    let storyboard = UIStoryboard(name: "Day1", bundle: nil)
    
  
    
    
    // 리스트를 받아올 변수
    var messageList : [Day1ChatMessageDataModel] = []
    var buttonCaseList : messageTypeList?
    
    @IBAction func ChatButtonAction(_ sender: Any) {
        switch (buttonCaseList) {
        case .compassButton:            
            NotificationCenter.default.post(name: NSNotification.Name("compassPresent"), object: nil)

            
        case .cameraButton:
            NotificationCenter.default.post(name: NSNotification.Name("cameraPresent"), object: nil)
            
        default:
            print("actionButtonCaseDefault")
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
    
    
    func setChatButton(buttonCase: messageTypeList){
        ChatFuncButton.setTitle("", for: .normal)
        buttonCaseList = buttonCase
        switch (buttonCase){
        case .compassButton:
            ChatFuncButton.setBackgroundImage(UIImage(named: "btnCompass"), for: .normal)
            
        case .cameraButton:
            print("셋 챗 버튼 함수 카메라 빠졌냐")
            ChatFuncButton.setBackgroundImage(UIImage(named: "btnPhoto"), for: .normal)
            
            
        default :
            print("case default")
        }
    }
    
    func loadingAnimate(idx : Int)
    {
        
        NotificationCenter.default.post(name: NSNotification.Name("scrollToBottom"), object: nil)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .allowUserInteraction) {
            
            
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.ChatFuncButton.alpha = 1
            })
            
        } completion: { (_) in
        }
        
        
        
    }
    
    func showMessageWithNoAnimation()
    {
        ChatFuncButton.alpha = 1
    }
    
    
    
//    // 사진, 비디오 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        // 미디어 종류 확인
//        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
//        
//        // 미디어 종류가 사진(Image)일 경우
//        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
//            
//            // 사진을 가져와 captureImage에 저장
//            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            
//            if flagImageSave { // flagImageSave가 true이면
//                // 사진을 포토 라이브러리에 저장
//                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
//            }
//            NotificationCenter.default.post(name: .sendImage, object: nil, userInfo: ["image": captureImage!])
//            
//        }
//        
//        
//        // 현재의 뷰 컨트롤러를 제거. 즉, 뷰에서 이미지 피커 화면을 제거하여 초기 뷰를 보여줌
//        viewController?.dismiss(animated: true, completion: nil)
//        
//    }
//    
//    // 사진, 비디오 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // 현재의 뷰(이미지 피커) 제거
//        viewController?.dismiss(animated: true, completion: nil)
//    }
//    
//    // 경고 창 출력 함수
//    func myAlert(_ title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
//        alert.addAction(action)
//        viewController?.present(alert, animated: true, completion: nil)
//    }
}
//
//extension NSNotification.Name {
//    static let sendImage = NSNotification.Name("sendImage")
//    
//}

