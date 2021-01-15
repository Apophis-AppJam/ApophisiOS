//
//  Day3ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//


import UIKit
import Lottie

class Day3ViewController: UIViewController {
    
    
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextInputView: UITextView!
    @IBOutlet weak var messageSendButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var massageInputAreaView: UIView!
    @IBOutlet weak var handBackgroundImage: UIImageView!
    @IBOutlet weak var roadBackgroundImage: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    
    
    //MARK:- Variable Part
    
    //  메세지 리스트
    
    var newMessageList : [ChatMessageNewDataModel] = []
    
    var messageListForTableView : [ChatMessageNewDataModel] = []
    
    var isMessageLoadList : [Bool] = []
        
    var isTextFieldEnabled : Bool = false
    
    let appData = UIApplication.shared.delegate as? AppDelegate
    
    
    
    
    //MARK:- Constraint Part
    
    
    @IBOutlet weak var messageInputAreaHeightConstraint: NSLayoutConstraint!
    // 메세지 input 창에서 줄바꿈할떄 영역 자체의 height 가 늘어나야 함
    
    @IBOutlet weak var messageInputAreaBottomConstraint: NSLayoutConstraint!
    
    //키보드 올라올떄 조절해야 하는 아래쪽 constraint
    
    
    //MARK:- Life Cycle Part
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appData?.chatIndex = 0
        
        addObserver()
        tableViewDefaultSetting()
        addTapAction()
        etcDefaultSetting()
        disableTextField(isEnable: isTextFieldEnabled)
        firstMessageLoad()
        
        
        //self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    
    //MARK:- IBAction Part
    
    
    // 홈버튼 클릭 했을 때
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때
    
    
    @IBAction func messageButtonClicked(_ sender: Any) {
        
        switch(newMessageList[newMessageList.count - 1].type)
        {
        case .normal :
            if newMessageList[newMessageList.count - 1].isMine == false // 마지막 메세지가 아포꺼면
            // userWithComplete 만 추가해야 함
            {
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: false,
                                                              nextMessageType: .userAnswerWithComplete,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: false,
                                                                       nextMessageType: .userAnswerWithComplete,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageTextInputView.text = ""
                
                isMessageLoadList.append(false)
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                
                DispatchQueue.global().sync {
                    chatTableView.insertRows(at: [finalIndex], with: .none)
                }
//                chatTableView.scrollToBottom()
                
                
                
            }
       
            else
            {
  
                
                
                
            }
        case .vibrate :
            if newMessageList[newMessageList.count - 1].isMine == false // 마지막 메세지가 아포꺼면
            // userWithComplete 만 추가해야 함
            {
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: false,
                                                              nextMessageType: .userAnswerWithComplete,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: false,
                                                                       nextMessageType: .userAnswerWithComplete,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageTextInputView.text = ""
                
                isMessageLoadList.append(false)
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                
                DispatchQueue.global().sync {
                    chatTableView.insertRows(at: [finalIndex], with: .none)
                }
//                chatTableView.scrollToBottom()
                
                
                
            }
            
        case .shutterSound :
            print("셔터사운드 넘어온다")
            if newMessageList[newMessageList.count - 1].isMine == false // 마지막 메세지가 아포꺼면
            // userWithComplete 만 추가해야 함
            {
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: false,
                                                              nextMessageType: .userAnswerWithComplete,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: false,
                                                                       nextMessageType: .userAnswerWithComplete,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageTextInputView.text = ""
                
                isMessageLoadList.append(false)
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                
                DispatchQueue.global().sync {
                    chatTableView.insertRows(at: [finalIndex], with: .none)
                }
//                chatTableView.scrollToBottom()
                
                
                
            }
            
        case .shutterAnimation :
            if newMessageList[newMessageList.count - 1].isMine == false // 마지막 메세지가 아포꺼면
            // userWithComplete 만 추가해야 함
            {
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: false,
                                                              nextMessageType: .userAnswerWithComplete,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: false,
                                                                       nextMessageType: .userAnswerWithComplete,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageTextInputView.text = ""
                
                isMessageLoadList.append(false)
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                
                DispatchQueue.global().sync {
                    chatTableView.insertRows(at: [finalIndex], with: .none)
                    
                    
                }
//                chatTableView.scrollToBottom()
                
                
                
            }
            
            
            
        case .userAnswerWithComplete :
            
            newMessageList.append(ChatMessageNewDataModel(messageContent: newMessageList[newMessageList.count - 1].messageContent,
                                                          isMine: true,
                                                          isLastMessage: false,
                                                          nextMessageType: .userAnswerWithComplete,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))

            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageListForTableView[messageListForTableView.count - 1].messageContent,
                                                                   isMine: true,
                                                                   isLastMessage: false,
                                                                   nextMessageType: .userAnswerWithComplete,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: messageListForTableView[messageListForTableView.count - 1].chatDetailsIdx))
            
            newMessageList.remove(at: newMessageList.count - 2)
            messageListForTableView.remove(at: newMessageList.count - 2)
            
            let reloadIndex = IndexPath(row: newMessageList.count - 1, section: 0)
            chatTableView.reloadRows(at: [reloadIndex], with: .none)
            
            // 이제 .userAnswerWIthComplete -> normal 완료했으면
            // 가장 최근에 입력한 거 .userANswerWIthComplete 형태로 만들어주기
            
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: false,
                                                          nextMessageType: .userAnswerWithComplete,
                                                          type: .userAnswerWithComplete,
                                                          dataList: [],
                                                          chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
            messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: false,
                                                                   nextMessageType: .userAnswerWithComplete,
                                                                   type: .userAnswerWithComplete,
                                                                   dataList: [],
                                                                   chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
            isMessageLoadList.append(false)
            let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
            
            
            DispatchQueue.global().sync {
                chatTableView.insertRows(at: [finalIndex], with: .none)
            }
            messageTextInputView.text = ""
//            chatTableView.scrollToBottom()
            
            
        case .lightBackground :
            if newMessageList[newMessageList.count - 1].isMine == false // 마지막 메세지가 아포꺼면
            // userWithComplete 만 추가해야 함
            {
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: false,
                                                              nextMessageType: .normal,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: false,
                                                                       nextMessageType: .normal,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
                
                messageTextInputView.text = ""
                
                isMessageLoadList.append(false)
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                
                DispatchQueue.global().sync {
                    chatTableView.insertRows(at: [finalIndex], with: .none)
                }
//                chatTableView.scrollToBottom()
                
                
                
            }
            
        default :
            let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
            
            let lastChatDetailsIndex = newMessageList[newMessageList.count - 1].chatDetailsIdx
            
            isMessageLoadList[newMessageList.count - 1] = false
            
            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: lastChatDetailsIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: lastChatDetailsIndex))
            
            
            

            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
    

        }
    }

    

    
    //MARK:- default Setting Function Part
    
    func firstMessageLoad()
    {
        self.loadApoMessage(idx: 41) { (result) in
                
                if result
                {
                    DispatchQueue.global().sync {
                        print("여기서 리스트",self.newMessageList)
                        self.messageListForTableView.append(self.newMessageList[0])
                        
                        let index = IndexPath(row: 0, section: 0)
                        self.chatTableView.insertRows(at: [index], with: .none)
                    }
                    
    //                self.chatTableView.scrollToBottom()

                }

            }


        }
        
    
    func getAponimousMessageFromServer(chatDetailsIdx : Int)
    {
        UIView.animateKeyframes(withDuration: 10, delay: 0,options: [], animations: {


                     UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {

//                         tableView.backgroundColor = .none
//                         cell.backgroundColor = UIColor.clear
//                         cell.contentView.backgroundColor = UIColor.clear
                         self.headerView.backgroundColor = .none
                         self.massageInputAreaView.backgroundColor = .none

                             })

                     UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15, animations: {

//                                 self.backgroundImageFirst.alpha = 0

                     })


                 }, completion: {_ in

                     let uvc = self.storyboard!.instantiateViewController(withIdentifier: "DrawingViewController")

                     uvc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

                     uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve


                     self.present(uvc, animated: true)

                 })
    }
    

    
    func addObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        

        NotificationCenter.default.addObserver(self, selector: #selector(receivedUserSelect), name: NSNotification.Name("receivedUserSelect"), object: nil)
        
        
        // 메세지 신호 처리
        NotificationCenter.default.addObserver(self, selector: #selector(aponimousMessageEnd), name: NSNotification.Name("AponimousMessageEnd"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(myMessageEnd), name: NSNotification.Name("myMessageEnd"), object: nil)
        
        //이름 입력했을 때
        NotificationCenter.default.addObserver(self, selector: #selector(userNameEntered), name: NSNotification.Name("userNameEntered"), object: nil)
        
        //유저 장문 메세지 전송
        NotificationCenter.default.addObserver(self, selector: #selector(userMessageEntered), name: NSNotification.Name("userMessageEntered"), object: nil)
        
        // 그림판 애니메이션
        
        NotificationCenter.default.addObserver(self, selector: #selector(setHandDrawing), name: NSNotification.Name("setHandDrawing"), object: nil)
     
        
        // 그림판 뷰 전환
        NotificationCenter.default.addObserver(self, selector: #selector(setDrawingButtonClicked), name: NSNotification.Name("setDrawingButtonClicked"), object: nil)
        
        // 그림판 뷰 완료
        NotificationCenter.default.addObserver(self, selector: #selector(endDrawing), name: NSNotification.Name("endDrawing"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setcolorPickerButtonClicked), name: NSNotification.Name("setcolorPickerButtonClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorPickerComplete), name: NSNotification.Name("colorPickerComplete"), object: nil)
        
        
    }
    
    
    //MARK:- @objc func 부분
    
    
    @objc func endDrawing(notification : NSNotification)
    {
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
            
            
        print("마지막 인덱스", newMessageList[lastIndex.row])
        print("메세지 리스트", newMessageList)
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        let lastChatDetailIDx =
            newMessageList[newMessageList.count - 1].chatDetailsIdx
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "응. 떠올렸어",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .userAnswerWithComplete,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: lastChatDetailIDx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "응. 떠올렸어",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .userAnswerWithComplete,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: lastChatDetailIDx))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
    }
    
    
    @objc func myMessageEnd(notification : NSNotification)
    {
        let index = notification.object as? Int ?? -1

        appData?.chatIndex = index
        

        if index != -1 // -1 이 올수가 없음
        {
            if newMessageList.count - 1 == index // 마지막 메세지라면 아포니머스 메세지 로드해야함
            {
                print("지금 보내고있는건 먼데여",newMessageList[index].chatDetailsIdx )
                
                if newMessageList[index].chatDetailsIdx == 28 // 지금 28번 없어서 패스하고 29번으로
                {
                    
                }
                
                
                else
                {
                    loadApoMessage(idx: newMessageList[index].chatDetailsIdx + 1) { (result) in
                        
                        if result
                        {
                            
                            DispatchQueue.global().sync {
                                self.messageListForTableView.append(self.newMessageList[index+1])

                                let index = IndexPath(row: index + 1, section: 0)
                                

                                self.chatTableView.beginUpdates()
                                self.chatTableView.insertRows(at: [index], with: .none)
                                self.chatTableView.endUpdates()
                            }
//                            self.chatTableView.scrollToBottom()

                        }
                        else
                        {
                            makeAlert(title: "알림", message: "메세지 정보를 불러오는데 실패하였습니다", vc: self)
                        }
                    }
                }
                


            }
            else if newMessageList.count - 1 > index  // 마지막 메세지가 아니라면
            {
                
                
                DispatchQueue.global().sync {
                    messageListForTableView.append(newMessageList[index+1])
                    let indexPath = IndexPath(row: index + 1, section: 0)
                    chatTableView.beginUpdates()
                    chatTableView.insertRows(at: [indexPath], with: .none)
                    chatTableView.endUpdates()
                }
                
//                chatTableView.scrollToBottom()
   
            }
            
            else
            {
                
            }
            

            
 
        }
        
        
    }
    
    @objc func aponimousMessageEnd(notification : NSNotification)
    {
        
        // 메세지 끝을 받으면 처리해야 하는 경우는 2가지
        // 1. 아까 받아온 메세지가 리스트에 남아있을 경우 해당 메세지의 행을 reload
        // 2. 마지막이라면 새로 데이터를 더 받아와야 한다
        
        let index = notification.object as? Int ?? 0
        // 여기서의 index는 방금 재생이 끝난 테이블 셀의 index를 의미함.
        
        
        if newMessageList.count - 1 == index // 지금 마지막 메세지를 재생하고 온 것. 새로 데이터를 받아와야 한다.
        {
            
            
            if newMessageList[index].nextMessageType == .userAnswerWithComplete
            // 다음으로 올 내용이 userAnswerWithComplete 부분이라면..?
            // 자동으로 다음 메세지를 받아오면 안된다...!
            // 대신 유저 키보드 열어줘야 함
            {
                    disableTextField(isEnable: true)
                    messageTextInputView.becomeFirstResponder()
            }
            else
            {
        

                loadMyMessage(idx: newMessageList[index].chatDetailsIdx,
                              type: newMessageList[index].nextMessageType) { (result) in
                    
                    if result
                    {
                        
                            self.messageListForTableView.append(self.newMessageList[index+1])
                            
                            let indexPath = IndexPath(row: index + 1, section: 0)
                            
                            self.chatTableView.beginUpdates()
                            self.chatTableView.insertRows(at: [indexPath], with: .none)
                            self.chatTableView.endUpdates()
                      
//                        self.chatTableView.scrollToBottom()
        
                    }
                }
                

            }
  


                
                
        }

            
 
         
  
        

    
        
 
        else if newMessageList.count - 1 > index // 마지막 메세지가 아니라면
        {
            DispatchQueue.global().sync {
                messageListForTableView.append(newMessageList[index+1])
                let indexPath = IndexPath(row: index + 1, section: 0)
                chatTableView.beginUpdates()
                chatTableView.insertRows(at: [indexPath], with: .none)
                chatTableView.endUpdates()
            }
            
//            chatTableView.scrollToBottom()
            
 
            
            
            
        }
        else
        {
            
            
//            chatTableView.reloadData()
        }
        
    }
    
    
    
        @objc func setDrawingButtonClicked()
        {
            let storyboard = UIStoryboard(name: "Day3", bundle: nil)
    
            guard let vc = storyboard.instantiateViewController(identifier: "Day3DrawingViewController") as? Day3DrawingViewController else  {return}
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            vc.drawIndex = messageListForTableView.count - 1
    
            self.present(vc, animated: true, completion: nil)
        }
    
    @objc func setcolorPickerButtonClicked()
    {
        
        let storyboard = UIStoryboard(name: "Day3", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day3ColorViewController") as? Day3ColorViewController else  {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)

    }

    
    
    @objc func userNameEntered(notification : NSNotification)
    {
        
        let nameList = notification.object as? [String] ?? []
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        isMessageLoadList[newMessageList.count - 1] = false
        
                    newMessageList.remove(at: newMessageList.count - 1)
                    messageListForTableView.remove(at: newMessageList.count - 1)
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: nameList[0],
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: nameList[0],
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
        
        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
    }
    
    
    @objc func userMessageEntered(notification : NSNotification)
    {
        
        let userMessageList = notification.object as? [String] ?? []
        
        isMessageLoadList[newMessageList.count - 1] = false
        
                    newMessageList.remove(at: newMessageList.count - 1)
                    messageListForTableView.remove(at: newMessageList.count - 1)
        
        //장문
        newMessageList.append(ChatMessageNewDataModel(messageContent: userMessageList[0],
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: userMessageList[0],
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: newMessageList[newMessageList.count - 1].chatDetailsIdx))
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)

        
        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
        
    }
    
    @objc func setHandDrawing()
    {
        
        massageInputAreaView.backgroundColor = .clear
        massageInputAreaView.backgroundColor = .none
        headerView.backgroundColor = .clear
        chatTableView.backgroundColor = .clear
        
        roadBackgroundImage.image = UIImage(named: "imgDay3Road")
        UIView.animate(withDuration: 2) {
            self.roadBackgroundImage.alpha = 1
            self.handBackgroundImage.alpha = 1
        }
        
        let time = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.roadBackgroundImage.alpha = 0
        
                }
        
    }
    
    
    @objc func startHandDrawing()
    {
        print("starthand끼야아아아앙아아아악")
        let storyboard = UIStoryboard(name: "Day3", bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: "Day3DrawingViewController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        

        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @objc func colorPickerComplete(notification : NSNotification)
    {
        
//        let messageDescription = notification.object as? String ?? ""
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
            
            
        print("마지막 인덱스", newMessageList[lastIndex.row])
        print("메세지 리스트", newMessageList)
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        let lastChatDetailIDx =
            newMessageList[newMessageList.count - 1].chatDetailsIdx
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "응. 떠올렸어",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .userAnswerWithComplete,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: lastChatDetailIDx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "응. 떠올렸어",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .userAnswerWithComplete,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: lastChatDetailIDx))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
    }
        
    
    
    @objc func handDrawingComplete(notification : NSNotification)
    {
        
//        let messageDescription = notification.object as? String ?? ""
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
            
            
        print("마지막 인덱스", newMessageList[lastIndex.row])
        print("메세지 리스트", newMessageList)
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        let lastChatDetailIDx =
            newMessageList[newMessageList.count - 1].chatDetailsIdx
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "그랬구나.",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .userAnswerWithComplete,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: lastChatDetailIDx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "그랬구나.",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .userAnswerWithComplete,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: lastChatDetailIDx))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
    }
    
    func hideBackgroundImage()
    {
        
        UIView.animate(withDuration: 2) {
            self.roadBackgroundImage.alpha = 0
            self.messageTextInputView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
            self.headerView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
            self.chatTableView.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
            
        }

   
    }
    
    
    func tableViewDefaultSetting()
    {
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = true
        chatTableView.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        
    }
    
    
    func etcDefaultSetting()
    {
        
        handBackgroundImage.alpha = 0
        
        // 네비게이션 바 숨기기
        self.navigationController?.navigationBar.isHidden = true
        
        // 헤더 타이틀 폰트 설정
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        subTitle.font = UIFont.gmarketFont(weight: .Medium, size: 12)
        
        
        messageTextInputView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextInputView.textColor = .init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        
        // 스와이프해서 뒤로 넘기는 기능 없애기
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        messageTextInputView.delegate = self
        
        
        let padding = messageTextInputView.textContainer.lineFragmentPadding
        messageTextInputView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        
        
        
        // 채팅창 닫기버튼 만들기
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        
        let normalAttributes : [NSAttributedString.Key: Any] = [
            .font : UIFont.gmarketFont(weight: .Medium, size: 14),
            .foregroundColor : UIColor.white
        ]
        
        
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissKeyBoard))
        button.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        
        toolBar.setItems([flexSpace,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        toolBar.tintColor = .white
        
        toolBar.barTintColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        messageTextInputView.inputAccessoryView = toolBar
        
        
    }
    
    
    
    func loadMyMessage(idx : Int, type : messageTypeList,completion: @escaping (Bool) -> Void)
    {
        getChatService.shared.getMyMessage(chatDetailIdx: idx, messageType: type) { (result) in
            switch(result)
            {
            case .success(let messageList, _):
                
                let message = messageList as? [ChatMessageNewDataModel] ?? []
                
                if message.count > 0
                {
                    for i in 0 ... message.count - 1
                    {
                        self.newMessageList.append(message[i])
                        self.isMessageLoadList.append(false)
                    }
                }
                completion(true)
                
            case .networkFail :
                completion(false)
                makeAlert(title: "알림", message: "네트워크 상태를 확인해주세요", vc: self)
                
            default :
                completion(false)
                makeAlert(title: "알림", message: "오류가 발생하였습니다", vc: self)
                
            }
        }
        
    }

    
    func loadApoMessage(idx : Int, completion: @escaping (Bool) -> Void)
    {
        
   
   
        getChatService.shared.getAponimousMessage(chatDetailIdx: idx) { (result) in
            switch(result)
            {
            case .success(let messageList, _):
                
                
          
                let message = messageList as? [ChatMessageNewDataModel] ?? []
                
                if message.count > 0
                {
                    for i in 0 ... message.count - 1
                    {
                        self.newMessageList.append(message[i])
                        self.isMessageLoadList.append(false)
                    }
                }
                
                completion(true)
                
            case .networkFail :
                makeAlert(title: "알림", message: "네트워크 상태를 확인해주세요", vc: self)
                completion(false)
                
            default :
                makeAlert(title: "알림", message: "오류가 발생하였습니다", vc: self)
                completion(false)
                
            }
            
            print("newMessageList",self.newMessageList)
        }
        
        
    
    }
    
    //MARK:- Function Part

    //키보드 액션 부분
    
    
    func addTapAction()
    {
//        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
//
//        view.addGestureRecognizer(tap)

    }
    
    @objc func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
         
            self.messageInputAreaBottomConstraint.constant = keyboardSize.height - 30
            UIView.animate(withDuration: 0 , animations: {
          
                self.view.layoutIfNeeded()

            }, completion: nil)

        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
           
        self.messageInputAreaBottomConstraint.constant = 0
        
        
        self.view.layoutIfNeeded()

    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    @objc func receivedUserSelect(notification : NSNotification)
    {
        let userSelect = notification.object as? String ?? ""
        
        self.messageTextInputView.text = userSelect
        self.messageTextInputView.textColor = .white
        textViewDidChange(messageTextInputView)
        
    }
    
    func disableTextField(isEnable: Bool)
    {
        if isEnable == true
        {
            messageTextInputView.isEditable = true
            messageTextInputView.isSelectable = true

        }
        else
        {
            messageTextInputView.isEditable = false
            messageTextInputView.isSelectable = false
        
 
        }
    }


}




//MARK:- extension 부분



extension Day3ViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("테이블셀눌림",indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension Day3ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageListForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // MARK:- 메세지 종류별 테이블 셀 만드는 부분
        
        if newMessageList[indexPath.row].isMine == true // 나의 메세지인 경우
        {
            
            switch(newMessageList[indexPath.row].type)
            {
            case .normal : // 나의 일반 메세지인 경우
                guard let myMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageCell", for: indexPath)
                        as? ChatMyMessageCell
                        else {return UITableViewCell() }
                
                myMessageCell.backgroundColor = .clear
                myMessageCell.selectionStyle = .none
                
                myMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                
                
                if isMessageLoadList[indexPath.row] == false
                {
                    myMessageCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    myMessageCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return myMessageCell
                

     
            case .userAnswerWithComplete:
                
                guard let myMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "Day2UserAnswerCompleteCell", for: indexPath)
                        as? Day2UserAnswerCompleteCell
                        else {return UITableViewCell() }
                
                myMessageCell.backgroundColor = .clear
                myMessageCell.selectionStyle = .none
                
                myMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                
                
                if isMessageLoadList[indexPath.row] == false
                {
                    myMessageCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    myMessageCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return myMessageCell

            case .ending:
            return UITableViewCell()
        
            case .select1In2:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                                        as? Day2selectAnswerCell
                                        else {return UITableViewCell() }
                                
                                selectCell.setSelectList(selectList: newMessageList[indexPath.row].dataList)
                selectCell.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
                selectCell.selectionStyle = .none
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
            case .setEraseButton:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                selectCell.ButtonClicked((Any).self)
                
                selectCell.setData(type: .setEraseButton)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
            case .setHandDrawing:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                selectCell.ButtonClicked((Any).self)
                
                selectCell.setData(type: .setHandDrawing)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
            case .colorPicker:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                selectCell.ButtonClicked((Any).self)
                
                selectCell.setData(type: .colorPicker)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
                
            case .enter3words:
                
                guard let enterWordCell = tableView.dequeueReusableCell(withIdentifier: "Day2word3InputCell", for: indexPath)
                        as? Day2word3InputCell
                else {return UITableViewCell() }
                
                enterWordCell.backgroundColor = .clear
                enterWordCell.selectionStyle = .none
                
                enterWordCell.setTextField()
                
                if isMessageLoadList[indexPath.row] == false
                {
                    enterWordCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    enterWordCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return enterWordCell
                
                
            case .selectValue:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                selectCell.setData(type: .selectValue)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
                
            case .select1:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                                        as? Day2selectAnswerCell
                                        else {return UITableViewCell() }
                                
                                selectCell.setSelectList(selectList: newMessageList[indexPath.row].dataList)
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
            case .selectList:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                                        as? Day2selectAnswerCell
                                        else {return UITableViewCell() }
                                
                                selectCell.setSelectList(selectList: newMessageList[indexPath.row].dataList)
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
                
                
            case .brightAndDark:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                selectCell.setData(type: .brightAndDark)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell
                
        
            default :
                return UITableViewCell()
            }


        }
        
        else // 아포니머스 메세지인 경우
        {
            
            switch(newMessageList[indexPath.row].type)

            {
            

            case .normal:
                
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                        else {return UITableViewCell() }


                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)

                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.loadingAnimate(index: indexPath.row, vibrate: false)
                }
                else
                {
                    yourMessageCell.showMessageWithNoAnimation()
                }

                isMessageLoadList[indexPath.row] = true

                yourMessageCell.backgroundColor = .clear
                return yourMessageCell
                
                
            case .vibrate :
                guard let vibrateCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                else {return UITableViewCell() }
                
                
                vibrateCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                vibrateCell.selectionStyle = .none
                vibrateCell.backgroundColor = .clear
                
                if isMessageLoadList[indexPath.row] == false
                {
                    vibrateCell.loadingAnimate(index: indexPath.row, vibrate: true)
                }
                else
                {
                    vibrateCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                
                return vibrateCell
                
                
//
//            case .lightBackground :
//
//
//                guard let lightCell =
//                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
//                        as? ChatYourMessageCell
//                else {return UITableViewCell() }
//
//
//                lightCell.setMessage(message: newMessageList[indexPath.row].messageContent)
//
//                if lightCheck == false {
//
//                    lightCheck = true
//                    lightCell.selectionStyle = .none
//                    lightCell.backgroundColor = .clear
//                    lightCell.lightBackground()
//
//                }
//
//                if isMessageLoadList[indexPath.row] == false
//                {
//                    lightCell.loadingAnimate(index: indexPath.row, vibrate: true)
//                }
//                else
//                {
//                    lightCell.showMessageWithNoAnimation()
//                }
//                isMessageLoadList[indexPath.row] = true
//
//
//                return lightCell
 
            case .normalWithSnow:
                
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                        else {return UITableViewCell() }


                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
   

                

                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.setSnowBackground()
                    yourMessageCell.loadingAnimate(index: indexPath.row, vibrate: false)
                }
                else
                {
                    yourMessageCell.showMessageWithNoAnimation()
                }

                isMessageLoadList[indexPath.row] = true

                yourMessageCell.backgroundColor = .clear
                return yourMessageCell
                
            case .setEraseButton:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                selectCell.setData(type: .setEraseButton)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell

            case .colorPicker:
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                selectCell.ButtonClicked((Any).self)
                
                
                selectCell.setData(type: .colorPicker)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    selectCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    selectCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return selectCell

            case .normalWithHandDrawing:
                
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                        else {return UITableViewCell() }


                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
   

                

                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.setHandDrawing()
                    yourMessageCell.loadingAnimate(index: indexPath.row, vibrate: false)
                }
                else
                {
                    yourMessageCell.showMessageWithNoAnimation()
                }

                isMessageLoadList[indexPath.row] = true

                yourMessageCell.backgroundColor = .clear
                return yourMessageCell
                
            default :
                return UITableViewCell()
            }

        }
    }
}


extension Day3ViewController : UITextViewDelegate
{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1) {
            textView.text = nil
            textView.textColor = .white
        }
        
        if textView.text == "텍스트를 입력하세요"
        {
            
            messageTextInputView.text = ""
            textView.textColor = .white
        }
        
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            return true
        }
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "텍스트를 입력해주세요"
            self.messageSendButton.isEnabled = false
            self.messageSendButton.setBackgroundImage(UIImage(named: "ChatSendButtonDisabled"), for: .normal)
            
            messageInputAreaHeightConstraint.constant = 75
            
            textView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        }
    }
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == self.messageTextInputView && textView.text != ""
        {
            //            self.messageTextInputView.sizeToFit()
            
            self.messageSendButton.isEnabled = true
            self.messageSendButton.setBackgroundImage(UIImage(named: "ChatSendButtonEnabled"), for: .normal)
            
            
            if self.messageTextInputView.numberOfLines() <= 8
            {
                
                messageInputAreaHeightConstraint.constant =
                    CGFloat(self.messageTextInputView.numberOfLines() - 1) * 14 + 75
                
            }
            
            
        }
        
        
        if textView == self.messageTextInputView && textView.text == ""
        {
            self.messageSendButton.isEnabled = false
            self.messageSendButton.setBackgroundImage(UIImage(named: "ChatSendButtonDisabled"), for: .normal)
            
        }
        
        
    }
    
}


