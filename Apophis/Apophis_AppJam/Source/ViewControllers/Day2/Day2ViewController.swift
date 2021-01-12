//
//  Day2ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class Day2ViewController: UIViewController {



    //MARK:- IBOutlet Part


    @IBOutlet weak var chatSnowImageView: UIImageView!
    

    @IBOutlet weak var messageSendButton: UIButton!
    @IBOutlet weak var messageTextInputView: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var messageInputView: UIView!
    
    
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

    }

    
    //MARK:- IBAction Part
    
    // 홈버튼 클릭 했을 때

    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때

    
    @IBAction func messageButtonClicked(_ sender: Any) {
        

          
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
    
    //MARK:- default Setting Function Par
    
    
    func firstMessageLoad()
    {


        
  
        
        self.loadApoMessage(idx: 23) { (result) in
            
            if result
            {
                print("여기서 리스트",self.newMessageList)
                self.messageListForTableView.append(self.newMessageList[0])
                
                
                let index = IndexPath(row: 0, section: 0)
                self.chatTableView.insertRows(at: [index], with: .none)
            }

            
        }




 

    }
    
    
    


    
    func addObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
 
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedUserSelect), name: NSNotification.Name("receivedUserSelect"), object: nil)
        
        
        // 메세지 신호 처리
        NotificationCenter.default.addObserver(self, selector: #selector(aponimousMessageEnd), name: NSNotification.Name("AponimousMessageEnd"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(myMessageEnd), name: NSNotification.Name("myMessageEnd"), object: nil)
        
        
        
        
        
        // 시간 설정 버튼 눌렸을 때,
        NotificationCenter.default.addObserver(self, selector: #selector(setTimeButtonClicked), name: NSNotification.Name("setTimeButtonClicked"), object: nil)
        
        
        // 시간 설정이 완료되었을 때
        NotificationCenter.default.addObserver(self, selector: #selector(setTimeComplete), name: NSNotification.Name("setTimeComplete"), object: nil)
        
        // 3개의 단어 입력이 완료되었을 때
        NotificationCenter.default.addObserver(self, selector: #selector(user3WordsEntered), name: NSNotification.Name("user3WordsEntered"), object: nil)
        
        
        // 장단점 부분 호출하기
        NotificationCenter.default.addObserver(self, selector: #selector(setBrightAndDark), name: NSNotification.Name("setBrightAndDark"), object: nil)
        
        // 장단점 완료
        NotificationCenter.default.addObserver(self, selector: #selector(brightDarkComplete), name: NSNotification.Name("brightDarkComplete"), object: nil)
        
        
        // 사용자 텍스트 입력받는 부분 숨길 때
        NotificationCenter.default.addObserver(self, selector: #selector(hideInputView), name: NSNotification.Name("hideInputView"), object: nil)
        
        
        // 눈길 배경 만들기
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSnowBackground), name: NSNotification.Name("setSnowBackground"), object: nil)
     

    }
    
    //MARK:- @objc func 부분
    
    @objc func hideInputView()
    {
        messageInputAreaHeightConstraint.constant = 0
        messageSendButton.isHidden = true
    }
    
    
    @objc func setSnowBackground()
    {
        messageInputView.backgroundColor = .clear
        headerView.backgroundColor = .clear
        chatTableView.backgroundColor = .clear

        
        
        chatSnowImageView.image = UIImage(named: "snowBG")
        UIView.animate(withDuration: 2) {
            self.chatSnowImageView.alpha = 1
        }
      
        
        
        let time = DispatchTime.now() + .seconds(10)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.hideBackgroundImage()
            
        }
        
        
    }
    
    func hideBackgroundImage()
    {
        UIView.animate(withDuration: 2) {
            self.chatSnowImageView.alpha = 0
            self.messageInputView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
            self.headerView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
            self.chatTableView.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
            
        }

   
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
                
                loadApoMessage(idx: newMessageList[index].chatDetailsIdx + 1) { (result) in
                    
                    if result
                    {
                        self.messageListForTableView.append(self.newMessageList[index+1])

                        let index = IndexPath(row: index + 1, section: 0)
                        

                        self.chatTableView.beginUpdates()
                        self.chatTableView.insertRows(at: [index], with: .none)
                        self.chatTableView.endUpdates()
                    }
                    else
                    {
                        makeAlert(title: "알림", message: "메세지 정보를 불러오는데 실패하였습니다", vc: self)
                    }
                }
                



            }
            else if newMessageList.count - 1 > index  // 마지막 메세지가 아니라면
            {
                messageListForTableView.append(newMessageList[index+1])
                let indexPath = IndexPath(row: index + 1, section: 0)
                chatTableView.beginUpdates()
                chatTableView.insertRows(at: [indexPath], with: .none)
                chatTableView.endUpdates()
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
            loadMyMessage(idx: newMessageList[index].chatDetailsIdx,
                          type: newMessageList[index].nextMessageType) { (result) in
                
                if result
                {
                    self.messageListForTableView.append(self.newMessageList[index+1])

                    let indexPath = IndexPath(row: index + 1, section: 0)
                    
                    self.chatTableView.beginUpdates()
                    self.chatTableView.insertRows(at: [indexPath], with: .none)
                    self.chatTableView.endUpdates()
                }

                
                
            }

            
 
      

            
         
         
            
        }
        
        

    
        
 
        else if newMessageList.count - 1 > index // 마지막 메세지가 아니라면
        {
            messageListForTableView.append(newMessageList[index+1])
            let indexPath = IndexPath(row: index + 1, section: 0)
            chatTableView.beginUpdates()
            chatTableView.insertRows(at: [indexPath], with: .none)
            chatTableView.endUpdates()
        }
        else
        {
            
            
//            chatTableView.reloadData()
        }
        
    }
    
    @objc func user3WordsEntered(notification : NSNotification)
    {
        
        messageSendButton.isHidden = false
        messageInputAreaHeightConstraint.constant = 75
        
        let words = notification.object as? [String] ?? []
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        

        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "첫 번째는 " + words[0],
                                                      isMine: true,
                                                      isLastMessage: false,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: 2))
        
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "두 번째는 " + words[1],
                                                      isMine: true,
                                                      isLastMessage: false,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: 2))
        
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "세 번째는 " + words[2],
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: 2))
        
        isMessageLoadList.append(contentsOf: [false,false])

        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "첫 번째는 " + words[0],
                                                               isMine: true,
                                                               isLastMessage: false,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: 2))
        
        chatTableView.reloadRows(at: [lastIndex], with: .none)



    }
    
    // 나의 장단점 버튼 클릭했을 떄 부분
    @objc func setBrightAndDark()
    {
        
        
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: "setLightDarkNavi")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        

        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func brightDarkComplete(notification : NSNotification)
    {
        let reason = notification.object as? [String] ?? []
        
        print("REASON",reason)
        

        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "나의 장단점은 이거야",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: 3))
        
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "나의 장단점은 이거야",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: 3))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
    }
    
    @objc func setTimeButtonClicked()
    {
        let storyboard = UIStoryboard(name: "Day2", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day2SelectTimeViewController") as? Day2SelectTimeViewController else  {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func setTimeComplete(notification : NSNotification)
    {
        let time = notification.object as? Int ?? 0
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "음, 나는 늦은 저녁에 떠날래",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: 1))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "음, 나는 늦은 저녁에 떠날래",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: 1))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
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
        // 배경 이미지 숨겨야 함
        chatSnowImageView.alpha = 0
        
        // 네비게이션 바 숨기기
        self.navigationController?.navigationBar.isHidden = true
        
        // 헤더 타이틀 폰트 설정
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        
        
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

    
    
    func loadApoMessage(idx : Int,completion: @escaping (Bool) -> Void)
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
        
        
     


//        if idx == 0
//        {
//
//            if isMine == false
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "안녕.",
//                                            isMine: false,
//                                            isLastMessage: true,
//                                            nextMessageType: .select1In2,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 0),
//
//                    ChatMessageNewDataModel(messageContent: "다시 연락했어. 짧은 시간이었지만 잘 지냈어?",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .select1In2,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 0),
//
//                    ChatMessageNewDataModel(messageContent: "오늘은 내내 눈이 오네. 조용히 그리고 가만히 쌓여가.",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .select1In2,
//                                            type: .normalWithSnow,
//                                            dataList: [],
//                                            chatDetailsIdx: 0),
//
//                    ChatMessageNewDataModel(messageContent: "난 지금 어제보다는 조금 더 너와 가까이 있어. 내 생에 처음으로 그 동쪽 끝 마을에서 벗어난거야.",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .select1In2,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 0),
//
//                    ChatMessageNewDataModel(messageContent: "지금 주변 조용하니? 혼자 있어?",
//                                            isMine: false,
//                                            isLastMessage: true,
//                                            nextMessageType: .select1In2,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 0)
//
//
//
//
//                ])
//
//                isMessageLoadList.append(contentsOf: [false,false,false,false,false])
//            }
//            else
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "",
//                                            isMine: true,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .select1In2,
//                                            dataList: ["응 마셨어.","딱히, 괜찮아."],
//                                            chatDetailsIdx: 0)
//                ])
//
//                isMessageLoadList.append(contentsOf: [false])
//            }
//
//        }
//
//        else if idx == 1
//        {
//            if isMine == false
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "오늘 나는 너에게 가는 길에 눈길을 밟았어!",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .normal,
//                                            dataList: [], chatDetailsIdx: 1),
//
//                    ChatMessageNewDataModel(messageContent: "음 그러고보니 너는 여행을 떠날 때 어떨지 궁금하다",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .normal,
//                                            dataList: [], chatDetailsIdx: 1),
//
//                    ChatMessageNewDataModel(messageContent: "만약 여행을 떠난다면 언제 집을 나서고 싶어?",
//                                            isMine: false,
//                                            isLastMessage: true,
//                                            nextMessageType: .setTimeButton,
//                                            type: .normal,
//                                            dataList: [], chatDetailsIdx: 1)
//                ])
//
//                isMessageLoadList.append(contentsOf: [false,false,false])
//            }
//            else
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "",
//                                            isMine: true,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .setTimeButton,
//                                            dataList: [], chatDetailsIdx: 1)
//                ])
//
//                isMessageLoadList.append(contentsOf: [false])
//            }
//
//        }
//
//        else if idx == 2
//        {
//            if isMine == false
//            {
//                newMessageList.append(contentsOf: [
//
//                    ChatMessageNewDataModel(messageContent: "그렇구나, 그렇다면 어떤 것들을 챙겨 가고 싶어?",
//                                            isMine: false,
//                                            isLastMessage: true,
//                                            nextMessageType: .enter3words,
//                                            type: .normal,
//                                            dataList: [], chatDetailsIdx: 2)
//                ])
//
//
//                isMessageLoadList.append(contentsOf: [false])
//            }
//            else
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "음...",
//                                            isMine: true,
//                                            isLastMessage: false,
//                                            nextMessageType: .enter3words,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 2),
//
//                    ChatMessageNewDataModel(messageContent: "",
//                                            isMine: true,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .enter3words,
//                                            dataList: [],
//                                            chatDetailsIdx: 2)
//
//
//                ])
//
//                isMessageLoadList.append(contentsOf: [false,false])
//            }
//
//        }
//
//
//        else if idx == 3
//        {
//            if isMine == false
//            {
//                newMessageList.append(contentsOf: [
//
//                    ChatMessageNewDataModel(messageContent: "음 그렇구나, 말해줘서 고마워. 너는 소중한 것이 있는 사림이구나.",
//                                            isMine: false,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 3),
//
//                    ChatMessageNewDataModel(messageContent: "너는 어떤 모습일지 궁금하다.",
//                                            isMine: false,
//                                            isLastMessage: true,
//                                            nextMessageType: .brightAndDark,
//                                            type: .normal,
//                                            dataList: [],
//                                            chatDetailsIdx: 3)
//
//
//                ])
//
//                isMessageLoadList.append(contentsOf: [false,false])
//            }
//            else
//            {
//                newMessageList.append(contentsOf: [
//                    ChatMessageNewDataModel(messageContent: "",
//                                            isMine: true,
//                                            isLastMessage: false,
//                                            nextMessageType: .normal,
//                                            type: .brightAndDark,
//                                            dataList: [],
//                                            chatDetailsIdx: 3),
//
//
//                ])
//
//                isMessageLoadList.append(contentsOf: [false])
//            }
//
//        }
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
         
            self.messageInputAreaBottomConstraint.constant = keyboardSize.height - 20
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



extension Day2ViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("테이블셀눌림",indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension Day2ViewController : UITableViewDataSource
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
                
            case .setTimeButton:
                
   
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2CircleButtonCell", for: indexPath)
                        as? Day2CircleButtonCell
                        else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.selectionStyle = .none
                
                selectCell.setData(type: .setTimeButton)
                
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
                
            default :
                return UITableViewCell()
            }

        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        

    }
    
    
}



extension Day2ViewController : UITextViewDelegate
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
            textView.text = "댓글을 입력해주세요"
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
