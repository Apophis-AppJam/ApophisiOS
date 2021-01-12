//
//  getChatService.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/04.
//

//

import Foundation
import Alamofire
import SwiftyJSON


struct getChatService {
    static let shared = getChatService()
    

       // MARK:- 아포니머스 메시지 받아오는 부분
    
    
    func getAponimousMessage(chatDetailIdx : Int,completion: @escaping (NetworkResult<Any>) -> Void) {
        
        print("여기는 이제 getAponimousMessage 시작", chatDetailIdx)
        let header: HTTPHeaders = ["content-Type": "application/json",
                                   "jwt" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWR4Ijo2LCJpYXQiOjE2MTAxNjM5NjIsImV4cCI6MTYxMDc2ODc2MiwiaXNzIjoiYXBvcGhpcyJ9.gM5avYDIhGybMsXqlvaWwqJCsTfkAjo1lYD2tvxZAdw"]
        // 임시로 두는 중

        let chatURL : String = APIConstants.getChatURL + "/" + String(chatDetailIdx)
        
        
        let dataRequest = AF.request(chatURL, method : .get, encoding:
                                        JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            
            
            case .success:
                
                
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                
                let json = JSON(value)
                
                let networkResult = self.judgeApo(index: chatDetailIdx, by: statusCode, json)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
      

    }


    private func judgeApo(index : Int, by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        switch statusCode {

        case 200 ... 299:  return loadAponimousMessageList(detailIndex: index, by: json)
        case 400 ... 499:  return .pathErr
        case 500 ... 599: return .serverErr
        default: return .networkFail
        }
    }


    private func loadAponimousMessageList(detailIndex : Int, by json: JSON) -> NetworkResult<Any> {


        let data = json["data"] as JSON
        let chat = data["chat"]



        var messageList : [ChatMessageNewDataModel] = []





        if chat.arrayValue.count > 0
        {
            for i in 0...chat.arrayValue.count - 1
            {
                
                if i == chat.arrayValue.count - 1 // 마지막 메세지인 경우
                {
                    let chat = ChatMessageNewDataModel(messageContent: chat[i]["text"].stringValue,
                                                       isMine: false,
                                                       isLastMessage: true,
                                                       nextMessageType: replyTypeFromKorean(replyType: data["postInfo"]["replyType"].stringValue),
                                                       type:
                                                        nextActionFromKorean(nextAction: chat[i]["nextAction"].stringValue),
                                                       dataList: [],
                                                       chatDetailsIdx: detailIndex)
                    
                    
                        messageList.append(chat)

                    
                }
                else // 마지막 메세지가 아닌 경우에
                {
                    // nextAction이 없으면 일반 메세지임
                        let chat = ChatMessageNewDataModel(messageContent: chat[i]["text"].stringValue,
                                                           isMine: false,
                                                           isLastMessage: false,
                                                           nextMessageType: .normal,
                                                           type: nextActionFromKorean(nextAction: chat[i]["nextAction"].stringValue),
                                                           dataList: [],
                                                           chatDetailsIdx: detailIndex)
                    
                    
                        messageList.append(chat)
                    

                }
                

     
            }
        }


        return .success(messageList,"0")
    }
    
    
    
    
    
    
    
    func getMyMessage(chatDetailIdx : Int,messageType : messageTypeList ,completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = ["content-Type": "application/json",
                                   "jwt" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWR4Ijo2LCJpYXQiOjE2MTAxNjM5NjIsImV4cCI6MTYxMDc2ODc2MiwiaXNzIjoiYXBvcGhpcyJ9.gM5avYDIhGybMsXqlvaWwqJCsTfkAjo1lYD2tvxZAdw"]

        let chatURL : String = APIConstants.baseURL + "/choice" + "/" + String(chatDetailIdx)

        let dataRequest = AF.request(chatURL, method : .get, encoding:
                                        JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            
            
            case .success:
                
                
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                
                let json = JSON(value)
                
                let networkResult = self.judgeMine(detailIndex: chatDetailIdx, type: messageType, by: statusCode, json)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
      

    }


    private func judgeMine(detailIndex : Int, type : messageTypeList, by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
        switch statusCode {

        case 200 ... 299:  return loadMyMessageList(detailIndex: detailIndex, type : type,by: json)
        case 400 ... 499:  return .pathErr
        case 500 ... 599: return .serverErr
        default: return .networkFail
        }
    }


    private func loadMyMessageList(detailIndex : Int, type : messageTypeList,by json: JSON) -> NetworkResult<Any> {


        let data = json["data"] as JSON
        let choiceWords = data["ChoiceWords"]



        var messageList : [ChatMessageNewDataModel] = []



        var choiceList : [String] = []

        if choiceWords.arrayValue.count > 0
        {
            for i in 0...choiceWords.arrayValue.count - 1
            {
                
                choiceList.append(choiceWords[i]["choiceWords"].stringValue)

            }
        }
            

            let chat = ChatMessageNewDataModel(messageContent: "",
                                               isMine: true,
                                               isLastMessage: false,
                                               nextMessageType: .normal,
                                               type: type,
                                               dataList: choiceList,
                                               chatDetailsIdx: detailIndex)
            

            
            messageList.append(chat)
            
            
            
        return .success(messageList,"0")
        }


    }
