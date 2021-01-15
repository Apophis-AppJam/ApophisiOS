//
//  Day1ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit
import MobileCoreServices


class Day1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var chatSeaImageView: UIImageView!
   
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextInputView: UITextView!
    @IBOutlet weak var messageSendButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var messageInputView: UIView!
    
    
    
    //MARK:- Variable Part
    
    //  메세지 리스트
    var newMessageList : [ChatMessageNewDataModel] = []
    
    var messageListForTableView : [ChatMessageNewDataModel] = []
    
    var isMessageLoadList : [Bool] = []
    
    var isUserEnterAnswer : Bool = false
    
    var isTextFieldEnabled : Bool = false
    
    let appData = UIApplication.shared.delegate as? AppDelegate
    
    var tempIndex : Int = 0
    
    // 찍은 사진을 담아둘 변수
    var pictureImage: UIImage!
    
    var checkImage: Bool = false
    
    // 형용사 위한 리스트
    var completeList: [String] = []
    var tempCompleteIndex: Int = 0
    
    // 사진 관련
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진을 저장할 변수
    var captureImage: UIImage!
    // 사진 저장 여부를 나타낼 변수
    var flagImageSave = false
    weak var viewController: UIViewController?

    
    
    //MARK:- Constraint Part
    
    @IBOutlet weak var messageInputAreaHeightConstraint: NSLayoutConstraint!
    // 메세지 input 창에서 줄바꿈할떄 영역 자체의 height 가 늘어나야 함
    @IBOutlet weak var messageInputAreaBottomConstraint: NSLayoutConstraint!
    //키보드 올라올떄 조절해야 하는 아래쪽 constraint
    
    
    //MARK:- Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        appData?.chatIndex = 0
        
        addObserver()
        tableViewDefaultSetting()
        etcDefaultSetting()
        disableTextField(isEnable: isTextFieldEnabled)
        
        
        firstMessageLoad()
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        addImageObserver()
    //        print("이미지 들어옴?", pictureImage)
    //
    //        if checkImage {
    //            let indexPath = IndexPath(row: messageList.count - 1 , section: 0)
    //            chatTableView.reloadRows(at: [indexPath] , with: .none)
    //
    //        }
    //    }
    
    
    
    //MARK:- IBAction Part
    
    // 홈버튼 클릭 했을 때
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때
    @IBAction func messageSendButtonClicked(_ sender: Any) {
        
        let lastLastIndex = newMessageList.count - 1
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        switch(newMessageList[lastLastIndex].type){
        
        // select1 인 경우
        case .select1 :
            isMessageLoadList[newMessageList.count - 1] = false
            
            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            tempIndex = newMessageList[newMessageList.count - 1].chatDetailsIdx
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: tempIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: tempIndex))
            
            
            
            
            isUserEnterAnswer = true
            
            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
            
        //            appData?.chatIndex = (appData?.chatIndex)! + 1
        //        }
        
        
        case .normal:
            if newMessageList[newMessageList.count - 1].isMine == false {
                print("너가뭔데",newMessageList[lastLastIndex])
                
                print("최초의 메세지")
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: true,
                                                              nextMessageType: .none,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: tempIndex))
                
                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: true,
                                                                       nextMessageType: .none,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: tempIndex))
                
                //isMessageLoadList[newMessageList.count - 1] = false
                //리로드할때 true를 false로 바꿔주는.. 여기서는 인서트이기때문에 필요가 없다
                //                print("마지막 인덱스", newMessageList[lastIndex.row])
                //                print("메세지 리스트", newMessageList)
                
                isMessageLoadList.append(false)
                messageTextInputView.text = ""
                
                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                chatTableView.insertRows(at: [finalIndex], with: .none)
            }
            
        case .selectAdjective:
            print("액션에서 케이스는 넘어가냐?")
            isMessageLoadList[newMessageList.count - 1] = false

            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            tempIndex = newMessageList[newMessageList.count - 1].chatDetailsIdx
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: tempIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: tempIndex))
            
            
            
            
            isUserEnterAnswer = true
            
            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
            
        case .userAnswerWithComplete :
            print("두번째 +  메세지")
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent: newMessageList[newMessageList.count - 1].messageContent,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: tempIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent: newMessageList[lastLastIndex].messageContent,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: tempIndex))
            
            print("두번째 메세지 마지막 인덱스", newMessageList[lastLastIndex])
            print("두번째메세지 메세지 리스트", newMessageList)
            
            newMessageList.remove(at: newMessageList.count - 2)
            messageListForTableView.remove(at: newMessageList.count - 2)
            
            
            let final = IndexPath(row: newMessageList.count - 1, section: 0)
            chatTableView.reloadRows(at: [final], with: .none)
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .userAnswerWithComplete,
                                                          dataList: [],
                                                          chatDetailsIdx: tempIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .userAnswerWithComplete,
                                                                   dataList: [],
                                                                   chatDetailsIdx: tempIndex))
            
            //isMessageLoadList[newMessageList.count - 1] = false
            //리로드할때 true를 false로 바꿔주는.. 여기서는 인서트이기때문에 필요가 없다
            //                print("마지막 인덱스", newMessageList[lastIndex.row])
            //                print("메세지 리스트", newMessageList)
            
            isMessageLoadList.append(false)
            messageTextInputView.text = ""
            
            let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
            chatTableView.insertRows(at: [finalIndex], with: .none)
            
        case .selectList :
            isMessageLoadList[newMessageList.count - 1] = false
            
            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            tempIndex = newMessageList[newMessageList.count - 1].chatDetailsIdx
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: tempIndex))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: tempIndex))
            
            
            
            
            isUserEnterAnswer = true
            
            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
            
            
            
        default :
            print("case default")
        }
        
    }
    
    
    //MARK:- default Setting Function Part
    func firstMessageLoad()
    {
        self.loadApoMessage(idx: 1) { (result) in
            if result
            {
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToBottom), name: NSNotification.Name("scrollToBottom"), object: nil)
        
        //유저 장문 메세지 전송
        NotificationCenter.default.addObserver(self, selector: #selector(userMessageEntered), name: NSNotification.Name("userMessageEntered"), object: nil)
        
        // 나침반 불러오기
        NotificationCenter.default.addObserver(self, selector: #selector(compassPresent), name: NSNotification.Name("compassPresent"), object: nil)
        // 나침반이 완료되었을 때
        NotificationCenter.default.addObserver(self, selector: #selector(compassComplete), name: NSNotification.Name("compassComplete"), object: nil)
        
        // 바다 배경 만들기
        NotificationCenter.default.addObserver(self, selector: #selector(setSeaBackground), name: NSNotification.Name("setSeaBackground"), object: nil)
        
        // 형용사 선택
        NotificationCenter.default.addObserver(self, selector: #selector(receivedAdjectiveSelect), name: NSNotification.Name("receivedAdjectiveSelect"), object: nil)
        // 형용사 선택 해제
        NotificationCenter.default.addObserver(self, selector: #selector(receivedAdjectiveUnselect), name: NSNotification.Name("receivedAdjectiveUnselect"), object: nil)
        
        // 사진 찍기
        NotificationCenter.default.addObserver(self, selector: #selector(cameraPresent), name: NSNotification.Name("cameraPresent"), object: nil)
        // 사진 받아오기
        NotificationCenter.default.addObserver(self, selector: #selector(getImage), name: NSNotification.Name("sendImage"), object: nil)
        // 사진 찍기가 완료되었을 때
        NotificationCenter.default.addObserver(self, selector: #selector(cameraComplete), name: NSNotification.Name("cameraComplete"), object: nil)

        
    }
  
    
    
    //MARK:- @objc func 부분
    
    @objc func scrollToBottom()
    {
        chatTableView.scrollToBottom()
    }
    
    @objc func myMessageEnd(notification : NSNotification)
    {
        let index = notification.object as? Int ?? -1
        
        if index != -1 // -1 이 올수가 없음
        {
            if newMessageList.count - 1 == index // 마지막 메세지라면 아포니머스 메세지 로드해야함
            {
                print("myMessageEnd에서 구한 newMessageList[index].chatDetailsIdx",newMessageList[index].chatDetailsIdx )
                
                loadApoMessage(idx: (newMessageList[index].chatDetailsIdx + 1)) { (result) in
                    
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
            
            //            chatTableView.scrollToRow(at: indexPath, at: .none, animated: true)
            
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
            if (self.newMessageList[self.newMessageList.count - 1].nextMessageType == .userAnswerWithComplete) {
                self.messageSendButton.isEnabled = true
                self.disableTextField(isEnable: true)
                self.messageTextInputView.becomeFirstResponder()
            }
            else {
                self.disableTextField(isEnable: false)

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
            
            
        }
        
        else if newMessageList.count - 1 > index // 마지막 메세지가 아니라면
        {
            messageListForTableView.append(newMessageList[index+1])
            let indexPath = IndexPath(row: index + 1, section: 0)
            
            DispatchQueue.global().sync {
                chatTableView.beginUpdates()
                chatTableView.insertRows(at: [indexPath], with: .none)
                chatTableView.endUpdates()
            }
            
        }
        
    }
    
    
    @objc func userMessageEntered(notification : NSNotification)
    {
        
        let userMessageList = notification.object as? [String] ?? []
        
        isMessageLoadList[newMessageList.count - 1] = false
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        tempIndex = newMessageList[newMessageList.count - 1].chatDetailsIdx
                
        newMessageList.append(ChatMessageNewDataModel(messageContent: userMessageList[0],
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: tempIndex))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: userMessageList[0],
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: tempIndex))
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
        
    }
    
    @objc func compassPresent()
    {
        let storyboard = UIStoryboard(name: "Day1", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: "Day1CompassViewController") as? Day1CompassViewController else  {return}
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.index = messageListForTableView.count-1
        print("여기는 인덱스 값을 넘기는거",messageListForTableView.count-1)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func setSeaBackground()
    {
        
        print("setseabackground 시작함")
        messageInputView.backgroundColor = .clear
        headerView.backgroundColor = .clear
        chatTableView.backgroundColor = .clear

        
        chatSeaImageView.image = UIImage(named: "seaBG")
        UIView.animate(withDuration: 2) {
            self.chatSeaImageView.alpha = 1
        }
      
        let time = DispatchTime.now() + .seconds(40)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.hideBackgroundImage()
            
        }
    }
    
    func hideBackgroundImage()
    {
        UIView.animate(withDuration: 2) {
            self.chatSeaImageView.alpha = 0
            self.messageInputView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
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
    }
    
    
    
    
    //MARK:- Function Part
    
    //키보드 액션 부분
    
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
    
    @objc func compassComplete(notification : NSNotification)
    {
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        let lastChatDetailIDx =
            newMessageList[newMessageList.count - 1].chatDetailsIdx
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "여긴가?",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .normal,
                                                      dataList: [],
                                                      chatDetailsIdx: lastChatDetailIDx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "여긴가?",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: lastChatDetailIDx))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
        disableTextField(isEnable: false)

    }
    
    func disableTextField(isEnable: Bool)
    {
        if isEnable == true
        {
            messageTextInputView.isEditable = true
            messageTextInputView.isSelectable = true
            messageSendButton.isEnabled = true
            
            
        }
        else
        {
            messageTextInputView.isEditable = false
            messageTextInputView.isSelectable = false
            messageSendButton.isEnabled = false
            
            
            
        }
    }
    
    // 형용사 선택 관련
    @objc func receivedAdjectiveSelect(notification : NSNotification)
    {
        let adjectiveSelect = notification.object as? String ?? ""
        completeList.append(adjectiveSelect)
        print("append", completeList)
        
        // 최종적으로 사용할 형용사 리스트
        var adjectiveList : [String] = []
        
        if completeList.count == 3 {

            for i in 0 ... 1 {
                adjectiveList.append(adjectiveCheck(adj: completeList[i]))
            }
            adjectiveList.append(completeList[2])
            
            self.messageTextInputView.text = "나는 \(adjectiveList[0]) \(adjectiveList[1]) \(adjectiveList[2]) 사람이야"
            self.messageTextInputView.textColor = .white
            textViewDidChange(messageTextInputView)
            
            disableTextField(isEnable: true)
        }
      
    }
    
    func adjectiveCheck(adj :String) -> String
    {
        if adj == "따뜻한"{
            return "따뜻하고"
        }
        else if adj == "담백한"{
            return "담백하고"
        }
        else if adj == "정열적인"{
            return "정열적이고"
        }
        else if adj == "냉소적인"{
            return "냉소적이고"
        }
        else if adj == "낭만적인"{
            return "낭만적이고"
        }
        else if adj == "현실적인"{
            return "현실적이고"
        }
        else if adj == "깊은"{
            return "깊고"
        }
        else if adj == "넓은"{
            return "넓고"
        }
        else if adj == "잔잔한"{
            return "잔잔하고"
        }
        else if adj == "강렬한"{
            return "강렬하고"
        }
        else if adj == "싱그러운"{
            return "싱그럽고"
        }
        else if adj == "성숙한"{
            return "성숙하고"
        }
        else if adj == "무게감 있는"{
            return "무게감 있고"
        }
        else if adj == "자유분방한"{
            return "자유분방하고"
        }
        else if adj == "수수한"{
            return "수수하고"
        }
        else if adj == "화려란"{
            return "화려하고"
        }
        else if adj == "유연한"{
            return "유연하고"
        }
        else if adj == "굳센"{
            return "굳세고"
        }
        else if adj == "단순한"{
            return "단순하고"
        }
        else {
            return "복잡하고"
        }
        
    }
    
    @objc func receivedAdjectiveUnselect(notification : NSNotification)
    {
        let adjectiveUnselect = notification.object as? String ?? ""
//        let tempindex: Int?
        
        for i in 0 ... completeList.count-1{
            if completeList[i] == adjectiveUnselect {
                tempCompleteIndex = i
            }
        }
        
        completeList.remove(at: tempCompleteIndex)
        print(tempCompleteIndex)
        self.messageTextInputView.text = ""
        self.messageTextInputView.textColor = .white
        
        disableTextField(isEnable: false)

     
    }
    
    // 사진 관련
    @objc func cameraPresent()
    {
        print("카메라 프레젠트 넘어옴?")
        
        // 카메라를 사용할 수 있다면(카메라의 사용 가능 여부 확인)
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            // 사진 저장 플래그를 true로 설정
            flagImageSave = true
            
            
            // 이미지 피커의 델리케이트 self로 설정
            imagePicker.delegate = self
            // 이미지 피커의 소스 타입을 camera로 설정
            imagePicker.sourceType = .camera
            // 미디어 타입 kUTTypeImage로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String]
            // 편집을 허용하지 않음
            imagePicker.allowsEditing = false
            
            
            // noti로 list 받아와 수정 후 return하는 함수
            //                addListObserver()
            
            // 현재 뷰 컨트롤러를 imagePicker로 대체. 즉 뷰에 imagePicker가 보이게 함
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            // 카메라를 사용할 수 없을 때는 경고창을 나타냄
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
            print("카메라 안켜진다")
        }
    }
    
    // 사진, 비디오 촬영이나 선택이 끝났을 때 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        // 미디어 종류가 사진(Image)일 경우
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            // 사진을 가져와 captureImage에 저장
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave { // flagImageSave가 true이면
                // 사진을 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            NotificationCenter.default.post(name: NSNotification.Name("sendImage"), object: nil, userInfo: ["image": captureImage!])
            
        }
    
        // 현재의 뷰 컨트롤러를 제거. 즉, 뷰에서 이미지 피커 화면을 제거하여 초기 뷰를 보여줌
        self.dismiss(animated: true, completion: {NotificationCenter.default.post(name: NSNotification.Name("cameraComplete"), object: nil) } )
        
    }
    
    // 사진, 비디오 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 현재의 뷰(이미지 피커) 제거
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    // 경고 창 출력 함수
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
//
//    private func addImageObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(getImage(_ :)), name: NSNotification.Name("sendImage"), object: nil)
//    }
//
    @objc func getImage(_ notification: Notification){
        guard let image = notification.userInfo?["image"] as? UIImage? else { return }
        pictureImage = image
        print("사진 들어왓냐??", pictureImage)
        if(pictureImage != nil){
            checkImage = true
        }
        
    }
    
    @objc func cameraComplete(notification : NSNotification)
    {
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        
        isMessageLoadList[newMessageList.count - 1] = false
        
        newMessageList.remove(at: newMessageList.count - 1)
        messageListForTableView.remove(at: newMessageList.count - 1)
        
        let lastChatDetailIDx =
            newMessageList[newMessageList.count - 1].chatDetailsIdx
        
        newMessageList.append(ChatMessageNewDataModel(messageContent: "",
                                                      isMine: true,
                                                      isLastMessage: true,
                                                      nextMessageType: .none,
                                                      type: .photo,
                                                      dataList: [],
                                                      chatDetailsIdx: lastChatDetailIDx))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: "",
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .photo,
                                                               dataList: [],
                                                               chatDetailsIdx: lastChatDetailIDx))


        chatTableView.reloadRows(at: [lastIndex], with: .none)
        disableTextField(isEnable: false)

    }
    
    
    
}


//MARK:- extension 부분

extension Day1ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
        
        
    }
    
    
}




extension Day1ViewController : UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageListForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //        if messageList[indexPath.row].isMine == true // 나의 메세지인 경우
        //        {
        //            guard let myMessageCell =
        //                    tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageCell", for: indexPath)
        //                    as? ChatMyMessageCell
        //            else {return UITableViewCell() }
        //
        //            myMessageCell.setMessage(message: messageList[indexPath.row].message)
        //            myMessageCell.backgroundColor = .clear
        //
        //            return myMessageCell
        //        }
        //        // 나침반을 부르는 경우
        //        else if(messageList[indexPath.row].Day1Func == 1){
        //            guard let ChatButtonCell =
        //                    tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
        //                    as? ChatButtonCell
        //            else {return UITableViewCell() }
        //
        //            ChatButtonCell.viewController = self
        //
        //            ChatButtonCell.index = indexPath.row
        //            ChatButtonCell.funcNum = messageList[indexPath.row].Day1Func
        //
        //            ChatButtonCell.setChatButton(ImgName: "btnCompass")
        //nCell
        //        }
        //        // 사진 기능을 부르는 경우
        //        else if(messageList[indexPath.row].Day1Func == 2){
        //            guard let ChatButtonCell =
        //                    tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
        //                    as? ChatButtonCell
        //            else {return UITableViewCell() }
        //
        //            ChatButtonCell.viewController = self
        //
        //            ChatButtonCell.index = indexPath.row
        //            ChatButtonCell.funcNum = messageList[indexPath.row].Day1Func
        //
        //            ChatButtonCell.setChatButton(ImgName: "btnPhoto")
        //
        //
        //
        //
        //            return ChatButtonCell
        //        }
        //
        //        // 사진을 찍고난 뒤 사진뷰를 불러오는 경우
        //        else if(messageList[indexPath.row].Day1Func == 5){
        //            guard let Day1ImageViewCell =
        //                    tableView.dequeueReusableCell(withIdentifier: "Day1ImageViewCell", for: indexPath)
        //                    as? Day1ImageViewCell
        //            else {return UITableViewCell() }
        //
        //            Day1ImageViewCell.setPictureImage(ImgName: pictureImage)
        //            Day1ImageViewCell.setImageView()
        //
        //            return Day1ImageViewCell
        //        }
        //
        //        else // 아포니머스 메세지인 경우
        //        {
        //            guard let yourMessageCell =
        //                    tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
        //                    as? ChatYourMessageCell
        //            else {return UITableViewCell() }
        //
        //            yourMessageCell.setMessage(message: messageList[indexPath.row].message)
        //
        //            return yourMessageCell
        //        }
        //    }
        //
        
        
        
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
                
                
                
                myMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                
                myMessageCell.selectionStyle = .none
                
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
                
                
            case .select1:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                        as? Day2selectAnswerCell
                else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.setSelectList(selectList: newMessageList[indexPath.row].dataList)
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
                
            case .userAnswerWithComplete:
                guard let myMessageWithCompleteCell = tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageWithCompleteCell", for: indexPath)
                        as? ChatMyMessageWithCompleteCell
                else {return UITableViewCell() }
                
                myMessageWithCompleteCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                myMessageWithCompleteCell.selectionStyle = .none
                
                if isMessageLoadList[indexPath.row] == false
                {
                    myMessageWithCompleteCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    myMessageWithCompleteCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return myMessageWithCompleteCell
                
            case .compassButton:
                guard let ChatButtonCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
                        as? ChatButtonCell
                else {return UITableViewCell() }
                
                
                ChatButtonCell.selectionStyle = .none
                ChatButtonCell.setChatButton(buttonCase: newMessageList[indexPath.row].type)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    ChatButtonCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    ChatButtonCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return ChatButtonCell
                
            case .cameraButton:
                guard let ChatButtonCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
                        as? ChatButtonCell
                else {return UITableViewCell() }
                
                
                ChatButtonCell.selectionStyle = .none
                ChatButtonCell.setChatButton(buttonCase: newMessageList[indexPath.row].type)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    ChatButtonCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    ChatButtonCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return ChatButtonCell
                
            case .selectAdjective:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                        as? Day2selectAnswerCell
                else {return UITableViewCell() }
                
                
                selectCell.backgroundColor = .clear
                selectCell.setAdjectiveList(selectList: newMessageList[indexPath.row].dataList)
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
                
            case .photo : // 나의 사진 메세지
                guard let myPhotoCell =
                        tableView.dequeueReusableCell(withIdentifier: "Day1ImageViewCell", for: indexPath)
                        as? Day1ImageViewCell
                else {return UITableViewCell() }
                
                
                
                myPhotoCell.setImageView()
                myPhotoCell.setPictureImage(ImgName: pictureImage)
                myPhotoCell.selectionStyle = .none
                
                if isMessageLoadList[indexPath.row] == false
                {
                    myPhotoCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    myPhotoCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return myPhotoCell
                
            case .selectList:
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                        as? Day2selectAnswerCell
                else {return UITableViewCell() }
                
                selectCell.backgroundColor = .clear
                selectCell.setSelectList(selectList: newMessageList[indexPath.row].dataList)
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
                
                
            case .enter3words:
                return UITableViewCell()
            case .brightAndDark:
                return UITableViewCell()
            default :
                return UITableViewCell()
            }
            
            
            
        }
        
        
        else // 아포니머스 메세지인 경우
        {
            switch(newMessageList[indexPath.row].type)
            {
            case .normal :
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                else {return UITableViewCell() }
                
                
                yourMessageCell.selectionStyle = .none
                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                
                // 애니메이션 안했으면 애니메이션 실행해주고 아니면 그냥 띄운다.
                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.loadingAnimate(index: indexPath.row, vibrate: false)
                    
                }
                else
                {
                    yourMessageCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return yourMessageCell
                
                
                
            case .vibrate :
                guard let vibrateCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                else {return UITableViewCell() }
                
                vibrateCell.selectionStyle = .none
                
                vibrateCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                
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
                
            case .photo:
                guard let apoImageViewCell =
                        tableView.dequeueReusableCell(withIdentifier: "Day1ApoImageViewCell", for: indexPath)
                        as? Day1ApoImageViewCell
                else {return UITableViewCell() }
                
                
//                apoImageViewCell.selectionStyle = .none
                apoImageViewCell.isSelected = false
                apoImageViewCell.setImageView(imgUrl: newMessageList[indexPath.row].messageContent)
                
                if isMessageLoadList[indexPath.row] == false
                {
                    apoImageViewCell.loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    apoImageViewCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return apoImageViewCell
                
            case .normalWithSea:
                print("셀 생성 normalwithsea 분기처리")
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                        else {return UITableViewCell() }


                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
   

                

                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.setSeaBackground()
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


extension Day1ViewController : UITextViewDelegate
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
            self.messageSendButton.setBackgroundImage(UIImage(named: "chatIcSendUnactivate"), for: .normal)
            
            textView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == self.messageTextInputView && textView.text != ""
        {
            self.messageTextInputView.sizeToFit()
            
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
            self.messageSendButton.setBackgroundImage(UIImage(named: "chatIcSendUnactivate"), for: .normal)
            
        }
        
        
    }
}


