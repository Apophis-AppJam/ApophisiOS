//
//  ChatMessageNewDataModel.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/04.
//

import Foundation



/// 채팅때 사용하는 메세지 데이터 모델입니다
///
/// - Description :
///     - message : 메세지 내용
///     - isLastMessage : 이 메세지 이후에 유저 응답이나 분기처리가 필요한 경우에 표시하게 됩니다
///            true이면은 이 메세지 다음에 유저 응답이 들어가야 하고, false 인 경우에는 아포니머스 메세지가 이어저야 합니다
///            (아포니머스만 사용함. 유저의 메세지는 전부 false 로 처리)
///
///     - isMine : 아포니머스 메세지인지, 유저의 메세지인지 구분하기 위한 변수입니다
///     - nextMessageType : 이 메세지에 다음으로 올 메세지가 어떤 종류인지 나타내기 위한 변수입니다
///     - type : 이 메세지가 어떤 종류인지 나타냅니다
///     - dataList : "넌 누구야","응","별로 믿기지 않아" 등 이렇게 선택지를 고르게 되는 경우 이러한 데이터를 담는 String 리스트입니다
///                                 필요없다면 빈 리스트로 저장을 합니다.
///

struct ChatMessageNewDataModel
{
    var messageContent : String
    var isMine : Bool
    var isLastMessage : Bool
    var nextMessageType : messageTypeList
    var type : messageTypeList
    var dataList : [String]
    var chatDetailsIdx : Int
}


enum messageTypeList
{
    
    case none
    // 아무 상관없을 때
    
    /* ============ 일반 메세지  ============ */
     
    
    case normal
    // 순수한 글자 메세지
    case photo
    // 사진 메세지
    case vibrate
    // 일반 메세지 + 진동

    case userAnswerWithComplete
    // 유저가 직접 입력할 수 있고, 완료하기 버튼이 있는 형태
    
    case selectList
    case voice
    case ending
    
    /* ============ 유저의 특별한 메세지  ============ */
    
    
    //MARK:- 유경 PART
    case enterName
    case voiceRecordButton
    case colorPicker

    
    //MARK:- 영재 PART
    case compassButton
    case camera
    case select1
    case select1In3
    case selectAdjective
    
    // MARK:- 지훈 PART
 
    case select1In2
    case setTimeButton
    case enter3words
    // 단어 3개 입력하는거
    
    case brightAndDark
    // 나의 장단점 입력하는거
    
    case normalWithSnow
    case normalWithSea
    
    case selectValue
    
    
    

}




