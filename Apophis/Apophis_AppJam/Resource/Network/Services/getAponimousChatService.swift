//
//  getAponimousChatService.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/04.
//

import Foundation
import Alamofire
import SwiftyJSON


//struct getAponimousChatService {
//    static let shared = getAponimousChatService()
//
//    
//    func getChattingList(detailIdx : Int,completion: @escaping (NetworkResult<Any>) -> Void) {
//        
//        
//        let header: HTTPHeaders = ["content-Type": "application/json","jwt" : "sewha"]
//        let boardURL : String = APIConstants.getChatURL + "/" + String(detailIdx)
//
//        
//        
//        let dataRequest = AF.request(boardURL, method : .get, encoding:
//            JSONEncoding.default, headers: header)
//        
//        
//
//        
//        dataRequest.responseData { dataResponse in
//            switch dataResponse.result {
//            
//            
//            case .success:
//                
//                
//                guard let statusCode = dataResponse.response?.statusCode else { return }
//                guard let value = dataResponse.value else { return }
//                
//                let json = JSON(value)
//                
//                let networkResult = self.judge(by: statusCode, json)
//                completion(networkResult)
//            case .failure:
//                completion(.networkFail)
//            }
//        }
//    }
//    
//    
//    private func judge(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
//        switch statusCode {
//            
//        case 200 ... 299:  return isChat(by: json)
//        case 400 ... 499:  return .pathErr
//        case 500 ... 599: return .serverErr
//        default: return .networkFail
//        }
//    }
//    
    
    

        
//        let data = json["data"] as JSON
//        let chatting = data["chat"]
//
//        
//        var boardList = [BoardListDataModel]()
//        
//        
//
//        
//        if board.arrayValue.count > 0
//        {
//            for i in 0...board.arrayValue.count - 1
//            {
//                let board = BoardListDataModel.init(subjectIdx:
//                                                    board[i]["subjectIdx"].intValue,
//                                                    title: board[i]["name"].stringValue,
//                                                          semester: semester)
//                                        
//                boardList.append(board)
//                      
//            }
//        }
//        
//        
//        return .success(boardList,"0")
//    }
//}
//
//}
//
