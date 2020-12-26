//
//  TimeCalculate.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import Foundation

public func currentTime() -> String
{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let currentTime = formatter.string(from: Date())

    return currentTime
}

/// 게시글이나 공지같은거 작성할때 서버 시간과 현재 시간을 비교해서
/// 10분전 , 1시간전 등 작성된 시간을 계산해주는 함수
///
///  - Parameters:
///    - date : YYYY-MM-DD HH:mm:ss 형태로 기입 되어야 함
///

public func slicingDate(date : String) -> String
{
    
    
    
    let UTCDate = Date()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 32400)
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    

    
    let defaultTimeZoneStr = formatter.string(from: UTCDate)
    

    let format = DateFormatter()
    var message : String = "" // 최종 결과값 담기위한 변수
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    format.locale = Locale(identifier: "ko_KR")
    

    let currentDate = Date()
    _ = format.string(from: currentDate)

    guard let tempDate = format.date(from: date) else {return ""}
    let krTime = format.date(from: defaultTimeZoneStr)
    

    let articleDate = format.string(from: tempDate)
    let useTime = Int(krTime!.timeIntervalSince(tempDate))
    
    
    if useTime < 60
    {
        message = "방금 전"
    }
    else if useTime < 3600
    {
        message = String(useTime/60) + "분 전"
    }
    else if useTime < 86400
    {
        message = String(useTime/3600) + "시간 전"
    }
    else
    {
        
        let timeArray = articleDate.components(separatedBy: " ")
        let dateArray = timeArray[0].components(separatedBy: "-")
        
        message = dateArray[1] + "월 " + dateArray[2] + "일"
    }
    
    
    return message
}
