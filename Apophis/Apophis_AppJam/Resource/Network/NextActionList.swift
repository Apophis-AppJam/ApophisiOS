//
//  NextActionList.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/10.
//

import Foundation


func nextActionFromKorean(nextAction : String) -> messageTypeList
{
    
    if nextAction == ""
    {
        return .normal
    }
    else if nextAction == "진동"
    {
        return .vibrate
    }
    else if nextAction == "채팅 이미지"
    {
        return .photo
    }
    else if nextAction == "엔딩 뷰"
    {
        return .ending
    }
    else if nextAction == "백그라운드 이미지 - 바다 뷰"
    {
        return .normalWithSea
    }
    else if nextAction == "백그라운드 이미지 - 눈길 뷰"
    {
        return .normalWithSnow
    }
    else if nextAction == "백그라운드 이미지 반짝"
    {
        return .lightBackground
    }
    else if nextAction == "음성송출"
    {
        return .voice
    }
    else if nextAction == "진동, 찰칵 음성"
    {
        return .shutterSound
    }
    else if nextAction == "진동, 찰칵 음성, 애니메이션-카메라 조리개"
    {
        return .shutterAnimation
    }
    
    else
    {
        return .normal
    }
    
    
    
}
