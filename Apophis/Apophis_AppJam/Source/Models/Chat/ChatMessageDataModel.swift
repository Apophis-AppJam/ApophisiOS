//
//  ChatMessageDataModel.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import Foundation

/// 채팅때 사용하는 메세지 데이터 모델입니다
///
/// - Description :
///     - message : 메세지 내용
///     - isLastMessage : 이 메세지 이후에 유저 응답이나 분기처리가 필요한 경우에 표시하게 됩니다
///            true이면은 이 메세지 다음에 유저 응답이 들어가야 하고, false 인 경우에는 아포니머스 메세지가 이어저야 합니다
///
///     - isMine : 아포니머스 메세지인지, 유저의 메세지인지 구분하기 위한 변수입니다
///

struct ChatMessageDataModel
{
    var message : String
    var isLastMessage : Bool
    var isMine : Bool
}
