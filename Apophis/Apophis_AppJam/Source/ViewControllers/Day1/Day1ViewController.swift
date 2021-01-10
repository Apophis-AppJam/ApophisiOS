//
//  Day1ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class Day1ViewController: UIViewController {
    
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextInputView: UITextView!
    @IBOutlet weak var messageSendButton: UIButton!
    
    
    
    
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
        
        // select1 인 경우
        if newMessageList[lastLastIndex].chatDetailsIdx == 0 || newMessageList[lastLastIndex].chatDetailsIdx == 1 || newMessageList[lastLastIndex].chatDetailsIdx == 2 || newMessageList[lastLastIndex].chatDetailsIdx == 3 || newMessageList[lastLastIndex].chatDetailsIdx == 4
        {
            print("여기는 Action 버튼을 눌렀을 때 실행되는 부분이란다.", newMessageList)
            print("여기는 lastLastIndex 값이란다.", lastLastIndex)
            print("newMessageList[lastLastIndex].chatDetailsIdx : ",newMessageList[lastLastIndex].chatDetailsIdx)
            

            let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
            print("전송 버튼 누를 때 detainIdx", newMessageList[lastLastIndex].chatDetailsIdx)
            print("전송 버튼 누를 때 List", newMessageList)

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
        }
    }
    
    
    //MARK:- default Setting Function Part
    func firstMessageLoad()
    {
        self.loadApoMessage(idx: 1) { (result) in
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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToBottom), name: NSNotification.Name("scrollToBottom"), object: nil)
        
        
        
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
                print("지금 보내고있는건 먼데여",newMessageList[index].chatDetailsIdx )
                print("지금 보내고있는 index ", index)
                print("지금 보내고있는 list ", newMessageList)
                
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
        
        print("이곳은 유어 메세지 엔드에서 들어오는 인덱스란다?", index )
        
        
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
            
            DispatchQueue.global().sync {
                chatTableView.beginUpdates()
                chatTableView.insertRows(at: [indexPath], with: .none)
                chatTableView.endUpdates()
            }

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
                print("로드아포메세지 func 여기서 chatDetailIdx가 뭐지?",idx)
                
                
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
    //    func loadDummyMessage(idx : Int,isMine : Bool)
    //    {
    //
    //        if idx == 0
    //        {
    //
    //            if isMine == false
    //            {
    //                newMessageList.append(contentsOf: [
    //                    ChatMessageNewDataModel(messageContent: "안녕",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 0),
    //
    //                    ChatMessageNewDataModel(messageContent: "먼저 나랑 연락을 이어나가겠다고 해줘서 고마워.",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 0),
    //
    //                    ChatMessageNewDataModel(messageContent: "세상이 7일 뒤에 멸망한다는데 대뜸 모르는 사람이 전화해서 당황했을 것 같아.",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .select1,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 0)
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false, false, false])
    //            }
    //            else
    //            {
    //                newMessageList.append(contentsOf: [
    //                    ChatMessageNewDataModel(messageContent: "",
    //                                            isMine: true,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .select1,
    //                                            dataList: ["음.. 그냥 받고 싶었어."],
    //                                            chatDetailsIdx: 0)
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false])
    //                tempIndex = idx
    //
    //            }
    //
    //        }
    //
    //
    //        else if idx == 1
    //        {
    //            if isMine == false
    //            {
    //                newMessageList.append(contentsOf: [
    //                    ChatMessageNewDataModel(messageContent: "사실 너한테 했던 게 딱 9번째 시도였어. 손가락으로 세어가면서. 번호를 바꿔가며 전화를 했지.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .vibrate,
    //                                            type: .normal,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "한 번.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .vibrate,
    //                                            type: .vibrate,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "두 번.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .vibrate,
    //                                            type: .vibrate,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "세 번.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .vibrate,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "10번까지 안 받으면 단념해야지 싶었는데. 딱 9번 째에 네가 받아준거야. ",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "누군가의 목소리가 들리는 순간 꿈 같았어. 이 난리통에 모르는 번호로 온 전화를 받는 사람이 어디 있겠어.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [], chatDetailsIdx: 1),
    //
    //                    ChatMessageNewDataModel(messageContent: "아 네가 이상하다는 건 아니야. 고맙다는 표현이라고 생각해줘. ",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .select1,
    //                                            type: .normal,
    //                                            dataList: [], chatDetailsIdx: 1)
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false,false,false,false,false,false,false])
    //            }
    //            else
    //            {
    //                newMessageList.append(contentsOf: [
    //                    ChatMessageNewDataModel(messageContent: "",
    //                                            isMine: true,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .select1,
    //                                            dataList: ["응. 그렇게 생각할게."], chatDetailsIdx: 1)
    //                ])
    //
    //
    //                isMessageLoadList.append(contentsOf: [false])
    //                tempIndex = idx
    //            }
    //
    //        }
    //
    //        else if idx == 2
    //        {
    //            if isMine == false
    //            {
    //
    //                newMessageList.append(contentsOf: [
    //
    //                    ChatMessageNewDataModel(messageContent: "지구가 멸망한다는 뉴스를 처음 봤을 때 말야. 그다지 실감이 안 났는데도 불구하고 마음이 쿵 내려앉더라. ",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .select1,
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
    //                    ChatMessageNewDataModel(messageContent: "",
    //                                            isMine: true,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .select1,
    //                                            dataList: ["쿵?"],
    //                                            chatDetailsIdx: 2)
    //
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false])
    //                tempIndex = idx
    //
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
    //                    ChatMessageNewDataModel(messageContent: "그래 쿵! 마치 소행성이 지구가 아니라 내 마음에 떨어진 것처럼 말야.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 3),
    //
    //                    ChatMessageNewDataModel(messageContent: "그 순간이 되니까 누군가와 이어져있고 싶더라고. 아무래도 사람과 이어져있는 게 불안함이 덜 하잖아. 나는 사실 딱히 이어져있다고 생각하는 관계들이 없었거든..",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .select1,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 3)
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
    //                                            type: .select1,
    //                                            dataList: ["음.."],
    //                                            chatDetailsIdx: 3),
    //
    //
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false])
    //                tempIndex = idx
    //
    //            }
    //
    //        }
    //
    //        else if idx == 4
    //        {
    //            if isMine == false
    //            {
    //                newMessageList.append(contentsOf: [
    //
    //                    ChatMessageNewDataModel(messageContent: "뭐. 이런 연락을 언젠가 한 번쯤 해보고 싶기도 했어. 마치 펜팔처럼.",
    //                                            isMine: false,
    //                                            isLastMessage: false,
    //                                            nextMessageType: .normal,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 4),
    //
    //                    ChatMessageNewDataModel(messageContent: "일면식도 없는 사람과 연락을 이어나가보는 거. 낭만적이지 않아? 생애 마지막쯤은 좀 낭만적이어도 되잖아.",
    //                                            isMine: false,
    //                                            isLastMessage: true,
    //                                            nextMessageType: .userAnswerWithComplete,
    //                                            type: .normal,
    //                                            dataList: [],
    //                                            chatDetailsIdx: 4)
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
    //                                            type: .userAnswerWithComplete,
    //                                            dataList: [""],
    //                                            chatDetailsIdx: 4),
    //
    //
    //                ])
    //
    //                isMessageLoadList.append(contentsOf: [false])
    //                tempIndex = idx
    //
    //            }
    //
    //        }
    //    }
    
    
    
    //MARK:- Function Part
    
    //키보드 액션 부분
    
    @objc func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
            self.messageInputAreaBottomConstraint.constant = keyboardSize.height
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
            messageSendButton.isEnabled = true
            
            
        }
        else
        {
            messageTextInputView.isEditable = false
            messageTextInputView.isSelectable = false
            messageSendButton.isEnabled = false
            
            
            
        }
    }
    
    // 사진 관련
    private func addImageObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getImage(_ :)), name: .sendImage, object: nil)
    }
    
    @objc func getImage(_ notification: Notification){
        guard let image = notification.userInfo?["image"] as? UIImage? else { return }
        pictureImage = image
        print("사진 들어왓냐??")
        if(pictureImage != nil){
            checkImage = true
        }
        
    }
    
    
    
}


//MARK:- extension 부분

extension Day1ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
//
//        let messageWidth = UIScreen.main.bounds.width * 230/375
//
//
//        let sampleTextView = UITextView()
//        sampleTextView.textAlignment = .left
//
//        sampleTextView.text = messageListForTableView[indexPath.row].messageContent
//        sampleTextView.font = .gmarketFont(weight: .Medium, size: 14)
//        sampleTextView.sizeToFit()
//        let lineNum = Int( sampleTextView.frame.width / messageWidth )
//
//
//
//        print("잘봐봡",sampleTextView.frame.width, messageWidth)
//
//        print("줄 갯수",lineNum)
//
//        print("컨테늧 내용",messageListForTableView[indexPath.row].messageContent)
//        print("")
//
//
//
//        return CGFloat(lineNum * 16 ) + 16.5 + 16 + 32
//        
        

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
        //
        //            return ChatButtonCell
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
        //            print("끼야아아아아아악",messageList)
        //            self.messageList.remove(at: messageList.count - 1)
        //            self.messageList.append(contentsOf: [Day1ChatMessageDataModel(message: "", isLastMessage: false, isMine: false, Day1Func: 5)])
        //            print("끼야아아아아아악2",messageList)
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
                
                
            case .userAnswerWithComplete:
                return UITableViewCell()
                
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
                return UITableViewCell()
                
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
            textView.text = "댓글을 입력해주세요"
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


