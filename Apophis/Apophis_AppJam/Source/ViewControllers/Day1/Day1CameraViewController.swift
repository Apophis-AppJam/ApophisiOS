//
//  Day1CameraViewController.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2020/12/31.
//

import UIKit
import MobileCoreServices

class Day1CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진을 저장할 변수
    var captureImage: UIImage!
    // 녹화한 비디오의 URL을 저장할 변수
    var videoURL: URL!
    // 사진 저장 여부를 나타낼 변수
    var flagImageSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btnCaptureImageFromCamera(_ sender: Any) {
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
            present(imagePicker, animated: true, completion: nil)
        } else {
            // 카메라를 사용할 수 없을 때는 경고창을 나타냄
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                    flagImageSave = false
                    
                    imagePicker.delegate = self
                    // 이미지 피커의 소스 타입을 PhotoLibrary로 설정
                    imagePicker.sourceType = .photoLibrary
                    
                    imagePicker.mediaTypes = [kUTTypeImage as String]
                    // 편집을 허용
                    imagePicker.allowsEditing = true
                    
                    present(imagePicker, animated: true, completion: nil)
                } else {
                    myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
                }
    }
    
    // 사진, 비디오 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
               imgView.image = captureImage // 가져온 사진을 이미지 뷰에 출력
            }
           // 현재의 뷰 컨트롤러를 제거. 즉, 뷰에서 이미지 피커 화면을 제거하여 초기 뷰를 보여줌
           self.dismiss(animated: true, completion: nil)
       }
       
       // 사진, 비디오 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           // 현재의 뷰(이미지 피커) 제거
           self.dismiss(animated: true, completion: nil)
       }
       
       // 경고 창 출력 함수
       func myAlert(_ title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
       }
    
}
