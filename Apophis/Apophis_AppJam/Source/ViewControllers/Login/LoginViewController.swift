//
//  LoginViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2021/01/03.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices


class LoginViewController: UIViewController {
    

    
    //MARK:- IBOutlet Part
    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용
    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!
    
    @IBOutlet weak var logoSubLabel: UILabel!
    @IBOutlet weak var easyLoginLabel: UILabel!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    

    //MARK:- Variable Part
    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용
    /// ex)  var imageViewList : [UIImageView] = []
    
//
//    var infoLabel: UILabel!
//    var profileImageView: UIImageView?
    
    
    //MARK:- Constraint Part
    /// 스토리보드에 있는 layout 에 대한 @IBOutlet 을 선언합니다. (Height, Leading, Trailing 등등..)  // 변수명 lowerCamelCase 사용
    /// ex) @IBOutlet weak var lastImageBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        logoSubLabel.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        
        easyLoginLabel.font = UIFont.gmarketFont(weight: .Medium, size: 12)
        

        let attributedString = NSMutableAttributedString(string: logoSubLabel.text!)

        // text의 range 색 변경
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 171/255, green: 112/255, blue: 245/255, alpha: 1), range: (logoSubLabel.text! as NSString).range(of: "당신의 이른 죽음"))

        // 설정이 적용된 text를 label의 attributedText에 저장
        logoSubLabel.attributedText = attributedString

        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBAction Part
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    /// ex) @IBAction func answerSelectedButtonClicked(_ sender: Any) {  code .... }
    
    @IBAction func onKakaoLoginByAppTouched(_ sender:       Any) {
        
//        // 카카오톡 설치 여부 확인
//          if (AuthApi.isKakaoTalkLoginAvailable()) {
//            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
//            AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    // 예외 처리 (로그인 취소 등)
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//                   // do something
//                    _ = oauthToken
//                   // 어세스토큰
//                   let accessToken = oauthToken?.accessToken
//                }
//            }
//          }
        
        //시뮬에 카카오톡이 없어서 웹브라우저로 연결
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            
            //do something
            _ = oauthToken
           }
            
            let accessToken = oauthToken?.accessToken
            self.setUserInfo()
        }
        
        
    }
    
    //구글 로그인
    @IBAction func onGoogleLoginByAppTouched(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    //애플 로그인
    @IBAction func onAppleLoginByAppTouched(_ sender: Any) {
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self as? ASAuthorizationControllerDelegate
        
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
        
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
    
    func setUserInfo() {
        
            UserApi.shared.me() {(user, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("me() success.")
                    //do something
//                    _ = user
//                    self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
//
//                    print(user?.kakaoAccount?.profile?.nickname)
//
//                    if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                        let data = try? Data(contentsOf: url) {
//                        self.profileImageView?.image = UIImage(data: data)
                    }
                }
            }
        }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // 사용자 정보 가져오기
        if let userId = user.userID,                  // For client-side use only!
            let idToken = user.authentication.idToken, // Safe to send to the server
            let fullName = user.profile.name,
            let givenName = user.profile.givenName,
            let familyName = user.profile.familyName,
            let email = user.profile.email {

            print("Token : \(idToken)")
            print("User ID : \(userId)")
            print("User Email : \(email)")
            print("User Name : \((fullName))")

        } else {
            print("Error : User Data Not Found")
        }
    }

    // 구글 로그인 연동 해제했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }


//MARK:- extension 부분
/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다
/// ex) extension ViewController : UICollectionViewDelegate {  code .... }


extension ViewController: ASAuthorizationControllerDelegate {
    
    //성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let user = credential.user
            print("User: \(user)")
            guard let email = credential.email else { return }
            print("email: \(email)")
        }
    }
    
    //실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print(error)
        
    }
    

    
}
