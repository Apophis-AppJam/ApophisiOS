//
//  makeAlert + UIView.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import Foundation
import UIKit

///  간단한 UIAlertViewController를 띄우는 함수입니다
///  사용 예시 ) makeAlert(title : "알림", message : "닉네임 변경이 완료되었습니다", vc : self)
///
/// - Parameters:
///     - title : alert 창의 제목 부분입니다
///     - message : alert 창에 본문 부분입니다
///     - vc : 이 alert 창을 띄울 viewcontroller 부분인데, 특별한 거 없으면 self로 써주세요!
///

public func makeAlert(title : String, message : String, vc : UIViewController)
{
    let alertViewController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
    alertViewController.addAction(action)
    vc.present(alertViewController, animated: true, completion: nil)
}

