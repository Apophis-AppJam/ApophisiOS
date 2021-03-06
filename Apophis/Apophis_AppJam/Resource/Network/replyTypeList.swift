//
//  replyTypeList.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/10.
//

import Foundation

func replyTypeFromKorean(replyType : String) -> messageTypeList
{
    if replyType == ""
    {
        return .normal
    }
    else if replyType == "단일 보기 선택"
    {
        return .select1
    }
    else if replyType == "장문형 텍스트 입력"
    {
        return .userAnswerWithComplete
    }
    else if replyType == "기능 액션 버튼 - 나침반"
    {
        return .compassButton
    }
    else if replyType == "카테고리 선택"
    {
        return .selectAdjective
    }
    else if replyType == "기능 액션 버튼 - 카메라"
    {
        return .cameraButton
    }
    else if replyType == "다중 보기 선택"
    {
        return .selectList
    }
    else if replyType == "다중 보기 선택 "
    {
        return .selectList
    }
    else if replyType == "기능 액션 버튼 - 가치 선택"
    {
        return .selectValue
    }
    else if replyType == "백그라운드 이미지 - 바다 뷰"
    {
        return .normalWithSea
    }
    else if replyType == "타로 장문형 텍스트 입력"
    {
        return .tarotText
    }
    else if replyType == "타로 음성 녹음"
    {
        // 우선 타로 텍스트 입려으로 뺀다
        return .tarotText
    }
    else if replyType == "reply 없음"
    {
        return .tarot
    }
    else if replyType == "기능 액션 버튼 - 시간대 설정"
    {
        return .setTimeButton
    }
    
    else if replyType == "다중 보기 선택 - 통신장애"
    {
        return .selectWithError
    }
    
    else if replyType == "단답형 텍스트 입력"
    {
        return .enter3words
    }
    else if replyType == "기능 액션 버튼 - 두개의 나 "
    {
        return .brightAndDark
    }
    else if replyType == "일차 종료 (reply 없음)"
    {
        return .ending
    }
    else if replyType == "기능 액션 버튼 - 얼룩 지우기"
    {
        return .setEraseButton
    }
    else if replyType == "기능 액션 버튼 - 컬러피커"
    {
        return .colorPicker
    }
    else if replyType == "기능 액션 버튼 - 그림판"
    {
        return .setHandDrawing
    }
    
    else
    {
        print("replyTypeFromKorean 에서 아무 경우도 안빠짐")
        return .normal
    }

}
