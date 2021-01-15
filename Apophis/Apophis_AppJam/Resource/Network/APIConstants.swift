//
//  APIConstants.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import Foundation


///
/// 서버 통신을 위해 URL을 기입하는 파일 부분입니다.
/// baseURL을 꼭 달아주세요!
///
/// ‼️ 기입 방법 ‼️
///  각자 개발하다가 필요한 URL 이 있는 경우에
///  ex) static let checkServerURL = APIConstants.baseURL + "/version"
///  를 적어주세요!
///
///  +) URL 변수 이름은 누가 봐도 알아 볼 수 있게 네이밍을 해주시면 됩니다!!
///
///   이 파일은 여러명이 사용하다 보니까 이름으로 구분된 곳에 URL을 기입해주세요!
///


struct APIConstants {
     
     

    static let baseURL = "http://52.78.210.107:3000"
    
    static let getChatURL = APIConstants.baseURL + "/chat"

    

    //MARK:- 유경 PART

    
    
    
    
    
    //MARK:- 영재 PART
    
    static let getChoiceURL = APIConstants.baseURL + "/choice"

    

    
    // MARK:- 지훈 PART

    
}
