//
//  Day3ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//


import UIKit

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
    
    
    //MARK:- Variable Part
    
    //  메세지 리스트
    
    var newMessageList : [ChatMessageNewDataModel] = []
    
    var messageListForTableView : [ChatMessageNewDataModel] = []
    
    var isMessageLoadList : [Bool] = []
    
    //에니메이션 중복 방지
    var isUserEnterAnswer : Bool = false
    
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
        
        
        loadDummyMessage(idx: (appData?.chatIndex)!, isMine: false)
        
        messageListForTableView.append(newMessageList[(appData?.chatIndex)!])
        
        let index = IndexPath(row: 0, section: 0)
        chatTableView.reloadRows(at: [index], with: .none)
        
        //self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    
    //MARK:- IBAction Part
    
    
    // 홈버튼 클릭 했을 때
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때
    
    
    @IBAction func messageButtonClicked(_ sender: Any) {
        
        
        // appData.chatIndex에 따라서 분기 처리 들어가야 합니다.
        
        let lastIndex =  IndexPath(row: newMessageList.count - 1, section: 0)
        
        print("여기서의 인덱스",lastIndex)
        
        
        if newMessageList[newMessageList.count - 1].chatDetailsIdx == 0 {
            

            
            isMessageLoadList[newMessageList.count - 1] = false
            
            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: 0))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: 0))
            
            
            
            
            isUserEnterAnswer = true
            
            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
            
        } else if newMessageList[newMessageList.count - 1].chatDetailsIdx == 1 {
            
            
            
            isMessageLoadList[newMessageList.count - 1] = false
            
            newMessageList.remove(at: newMessageList.count - 1)
            messageListForTableView.remove(at: newMessageList.count - 1)
            
            
            newMessageList.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .normal,
                                                          dataList: [],
                                                          chatDetailsIdx: 1))
            
            messageListForTableView.append(ChatMessageNewDataModel(messageContent:  messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .normal,
                                                                   dataList: [],
                                                                   chatDetailsIdx: 1))
            
            
            
            
            isUserEnterAnswer = true
            
            chatTableView.reloadRows(at: [lastIndex], with: .none)
            
            messageTextInputView.text = ""
            textViewDidChange(messageTextInputView)
            
        } else if newMessageList[newMessageList.count - 1].chatDetailsIdx == 2 {
            
            
            if newMessageList[newMessageList.count - 1].isMine == false {
                
                newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                          isMine: true,
                                                          isLastMessage: true,
                                                          nextMessageType: .none,
                                                          type: .enterName,
                                                          dataList: [],
                                                          chatDetailsIdx: 2))

                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .enterName,
                                                                   dataList: [],
                                                                   chatDetailsIdx: 2))

            isMessageLoadList.append(false)
                messageTextInputView.text = ""

                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
            chatTableView.insertRows(at: [finalIndex], with: .none)
                
            } } else if newMessageList[newMessageList.count - 1].chatDetailsIdx == 3 {
                
                
                if newMessageList[newMessageList.count - 1].isMine == false {
                    print("너가뭔데",newMessageList[lastIndex.row])
                    print("최초의 메세지")
                    newMessageList.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                              isMine: true,
                                                              isLastMessage: true,
                                                              nextMessageType: .none,
                                                              type: .userAnswerWithComplete,
                                                              dataList: [],
                                                              chatDetailsIdx: 3))

                    messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                       isMine: true,
                                                                       isLastMessage: true,
                                                                       nextMessageType: .none,
                                                                       type: .userAnswerWithComplete,
                                                                       dataList: [],
                                                                       chatDetailsIdx: 3))
                    
                    //isMessageLoadList[newMessageList.count - 1] = false
                    //리로드할때 true를 false로 바꿔주는.. 여기서는 인서트이기때문에 필요가 없다
    //                print("마지막 인덱스", newMessageList[lastIndex.row])
    //                print("메세지 리스트", newMessageList)

                isMessageLoadList.append(false)
                    messageTextInputView.text = ""

                    let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
                chatTableView.insertRows(at: [finalIndex], with: .none)
                    
                }
                
                else {
                
                // 2번째에서는
                
                print("두번째 +  메세지")
                    newMessageList.append(ChatMessageNewDataModel(messageContent: newMessageList[newMessageList.count - 1].messageContent,
                                                              isMine: true,
                                                              isLastMessage: true,
                                                              nextMessageType: .none,
                                                              type: .normal,
                                                              dataList: [],
                                                              chatDetailsIdx: 3))

                    messageListForTableView.append(ChatMessageNewDataModel(messageContent: newMessageList[lastIndex.row].messageContent,
                                                                       isMine: true,
                                                                       isLastMessage: true,
                                                                       nextMessageType: .none,
                                                                       type: .normal,
                                                                       dataList: [],
                                                                       chatDetailsIdx: 3))
                
                print("두번째 메세지 마지막 인덱스", newMessageList[lastIndex.row])
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
                                                          chatDetailsIdx: 3))

                messageListForTableView.append(ChatMessageNewDataModel(messageContent: messageTextInputView.text,
                                                                   isMine: true,
                                                                   isLastMessage: true,
                                                                   nextMessageType: .none,
                                                                   type: .userAnswerWithComplete,
                                                                   dataList: [],
                                                                   chatDetailsIdx: 3))
                
                //isMessageLoadList[newMessageList.count - 1] = false
                //리로드할때 true를 false로 바꿔주는.. 여기서는 인서트이기때문에 필요가 없다


            isMessageLoadList.append(false)
                messageTextInputView.text = ""

                let finalIndex = IndexPath(row: newMessageList.count - 1, section: 0)
            chatTableView.insertRows(at: [finalIndex], with: .none)
                
                
                
                
                
                
                
        }
        
        }
    
}

    

    
    //MARK:- default Setting Function Part
    
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(startHandDrawing), name: NSNotification.Name("startHandDrawing"), object: nil)
        
        // 그림판 뷰 완료
        NotificationCenter.default.addObserver(self, selector: #selector(endDrawing), name: NSNotification.Name("endDrawing"), object: nil)
    }
    
    
    //MARK:- @objc func 부분
    
    
    @objc func endDrawing(notification : NSNotification)
    {
        // 메세지 끝을 받으면 처리해야 하는 경우는 2가지
        // 1. 아까 받아온 메세지가 리스트에 남아있을 경우 해당 메세지의 행을 reload
        // 2. 마지막이라면 새로 데이터를 더 받아와야 한다

        print("뉴메세지리스트",newMessageList)
        print("테이블리스트",messageListForTableView)

        print("TableViewCount",newMessageList[messageListForTableView.count - 1])
        
        messageListForTableView.append(newMessageList[messageListForTableView.count - 1])
        let indexPath = IndexPath(row: messageListForTableView.count - 1, section: 0)
        
        chatTableView.beginUpdates()
        chatTableView.insertRows(at: [indexPath], with: .none)
        chatTableView.endUpdates()
  
        
    }
    
    
    @objc func myMessageEnd(notification : NSNotification)
    {
        let index = notification.object as? Int ?? -1
        
        
//        appData?.chatIndex = index
        
        
        if index != -1 // -1 이 올수가 없음
        {
            //장문 대답 인덱스 와야함요
            if newMessageList[index].chatDetailsIdx == 3 {
                
                loadDummyMessage(idx: newMessageList[index].chatDetailsIdx + 1, isMine: false)
                            
                            
                            
                            messageListForTableView.append(newMessageList[index+1])
                            //            isMessageLoadList.append(false)
                            
                            let index = IndexPath(row: index + 1, section: 0)
                            
                            
                            chatTableView.beginUpdates()
                            chatTableView.insertRows(at: [index], with: .none)
                            chatTableView.endUpdates()
                            print("메세지 리스트", newMessageList)
                
            } else {
            
            loadDummyMessage(idx: newMessageList[index].chatDetailsIdx + 1, isMine: false)
            
            
            
            messageListForTableView.append(newMessageList[index+1])
            //            isMessageLoadList.append(false)
            
            
            let index = IndexPath(row: index + 1, section: 0)
            
            
            chatTableView.beginUpdates()
            chatTableView.insertRows(at: [index], with: .none)
            chatTableView.endUpdates()
                
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
        
        print("@@@@@@@@@@@@@@@@ ##### 방금 받은 index",index)
        if newMessageList.count - 1 == index // 지금 마지막 메세지를 재생하고 온 것. 새로 데이터를 받아와야 한다.
        {
            
            //장문 메세지
            if newMessageList[index].chatDetailsIdx == 3 {
                //
                print("메세지 리스트", newMessageList)
            } else {
            
            loadDummyMessage(idx: newMessageList[index].chatDetailsIdx,
                             isMine: !newMessageList[index].isMine)
            
            
            
            
            messageListForTableView.append(newMessageList[index+1])
            
            
            
            let indexPath = IndexPath(row: index + 1, section: 0)
            
            chatTableView.beginUpdates()
            chatTableView.insertRows(at: [indexPath], with: .none)
            chatTableView.endUpdates()
            
            
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
    
        @objc func drawingButtonClicked()
        {
            let storyboard = UIStoryboard(name: "Day3ViewController", bundle: nil)
    
            guard let vc = storyboard.instantiateViewController(identifier: "Day3DrawingViewController") as? Day3DrawingViewController else  {return}
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            vc.drawIndex = messageListForTableView.count - 1
    
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
                                                      chatDetailsIdx: 2))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: nameList[0],
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: 2))
        
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
                                                      chatDetailsIdx: 3))
        
        messageListForTableView.append(ChatMessageNewDataModel(messageContent: userMessageList[0],
                                                               isMine: true,
                                                               isLastMessage: true,
                                                               nextMessageType: .none,
                                                               type: .normal,
                                                               dataList: [],
                                                               chatDetailsIdx: 3))
        
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
        
//        handBackgroundImage.image = UIImage(named: "handBackgroundImage")
//        UIView.animate(withDuration: 2) {
//            self.handBackgroundImage.alpha = 1
//        }
//
        
//        let time = DispatchTime.now() + .seconds(5)
//        DispatchQueue.main.asyncAfter(deadline: time) {
//            self.hideBackgroundImage()
//
//        }
//
//        UIView.animate(withDuration: 2) {
//            self.roadBackgroundImage.alpha = 0
//            self.messageTextInputView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
//            self.headerView.backgroundColor = .init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
//            self.chatTableView.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
//        }
        
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
    
    
    
    
    
    func loadDummyMessage(idx : Int,isMine : Bool)
    {
        
        if idx == 0
        {
            
            if isMine == false
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "오늘은 어때? 이번에는 좋아하는 향이 있으면 뿌리고 얘기해볼까?" ,
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .select1In2,
                                            type: .normal,
                                            dataList: [],
                                            chatDetailsIdx: 0)
                ])
                
                isMessageLoadList.append(contentsOf: [false])
            }
            else
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "",
                                            isMine: true,
                                            isLastMessage: false,
                                            nextMessageType: .normal,
                                            type: .select1In2,
                                            dataList: ["응 뿌렸어.","괜찮아."],
                                            chatDetailsIdx: 0)
                ])
                
                isMessageLoadList.append(contentsOf: [false])
            }
            
        }
        
        else if idx == 1
        {
            if isMine == false
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "오늘 여행길에서 본 풍경이야! 되게 예쁘지?",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .normalWithHandDrawing,
                                            dataList: [], chatDetailsIdx: 1),
                    
                ])
                
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "그런데, 길을 걷다가 어떤 사람들이 나를 멈춰세우더라.",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .normal,
                                            dataList: [], chatDetailsIdx: 1),
                    
                ])
                
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "그러더니, 자기들 손목을 묶어달라는거야.",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .normalWithStartHandDrawing,
                                            dataList: [], chatDetailsIdx: 1),
                    
                ])
                
                
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "죽을 때 까지 떨어지기 싫다더라.",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .normal,
                                            dataList: [], chatDetailsIdx: 1),
                    
                ])
                
                
                
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "너의 관계가 궁금해지는 순간이었어. 음 너는 온 힘을 다해 좋아한 사람이 있어?" ,
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .select1In2,
                                            type: .normal,
                                            dataList: [],
                                            chatDetailsIdx: 1),
             ])
                
                isMessageLoadList.append(contentsOf: [false, false, false, false, false])
                
            }
            
            else {
                
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "",
                                            isMine: true,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .select1In2,
                                            dataList: ["응 있어.","음 글쎄."],
                                            chatDetailsIdx: 1)
                ])
                
                isMessageLoadList.append(contentsOf: [false])
                
            }
            
            
        } else if idx == 2
        {
            if isMine == false
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "그 사람 이름이 뭐야?",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .enterName,
                                            type: .normal,
                                            dataList: [], chatDetailsIdx: 2),
                    
                ])
                
                isMessageLoadList.append(contentsOf: [false])
            }
            else
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "",
                                            isMine: true,
                                            isLastMessage: true,
                                            nextMessageType: .normal,
                                            type: .enterName,
                                            dataList: [], chatDetailsIdx: 2)
                ])
                
                isMessageLoadList.append(contentsOf: [false])
            }
            
            
        } else if idx == 3
        
        {
            if isMine == false
            {
                newMessageList.append(contentsOf: [
                    
                    ChatMessageNewDataModel(messageContent: "그 사람은 어떤 사람이야?",
                                            isMine: false,
                                            isLastMessage: false,
                                            nextMessageType: .none,
                                            type: .normal,
                                            dataList: [], chatDetailsIdx: 3),
                    
                    ChatMessageNewDataModel(messageContent: "어떤 얘기를 하고 싶어?",
                                            isMine: false,
                                            isLastMessage: true,
                                            nextMessageType: .userAnswerWithComplete,
                                            type: .normal,
                                            dataList: [],
                                            chatDetailsIdx: 3)
                ])
                
                self.messageSendButton.isEnabled = true
                disableTextField(isEnable: true)
                
                isMessageLoadList.append(contentsOf: [false,false])
            }
            
            else
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "",
                                            isMine: true,
                                            isLastMessage: false,
                                            nextMessageType: .none,
                                            type: .userAnswerWithComplete,
                                            dataList: [],
                                            chatDetailsIdx: 3)
                    
                    
                ])
                
                isMessageLoadList.append(contentsOf: [false])
                
            }

            
        }
        
        
        else if idx == 4
        {
            if isMine == false
            {
                newMessageList.append(contentsOf: [

                    ChatMessageNewDataModel(messageContent: "한 번 소리내어 읽어보는것도 좋을 것 같은데?",
                                            isMine: false,
                                            isLastMessage: false,
                                            nextMessageType: .normal,
                                            type: .normal,
                                            dataList: [],
                                            chatDetailsIdx: 4),

                ])

                isMessageLoadList.append(contentsOf: [false])
            }
            else
            {
                newMessageList.append(contentsOf: [
                    ChatMessageNewDataModel(messageContent: "",
                                            isMine: true,
                                            isLastMessage: false,
                                            nextMessageType: .normal,
                                            type: .brightAndDark,
                                            dataList: [],
                                            chatDetailsIdx: 4),


                ])

                isMessageLoadList.append(contentsOf: [false])
            }

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
                    myMessageCell   .loadingAnimate(idx: indexPath.row)
                }
                else
                {
                    myMessageCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return myMessageCell
                
                
                
            case .userAnswerWithComplete:
                
                guard let myMessageWithCompleteCell = tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageWithCompleteCell", for: indexPath)
                        as? ChatMyMessageWithCompleteCell
                else {return UITableViewCell() }
                
                myMessageWithCompleteCell.backgroundColor = .clear
                myMessageWithCompleteCell.selectionStyle = .none
                myMessageWithCompleteCell.setMessage(message: newMessageList[indexPath.row].messageContent)
                myMessageWithCompleteCell.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
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
                
                
            case .enterName:
                
                guard let enterNameCell = tableView.dequeueReusableCell(withIdentifier: "Day3EnterNameCell", for: indexPath)
                        as? Day3EnterNameCell
                else { return UITableViewCell() }
                
                enterNameCell.backgroundColor = .clear
                enterNameCell.selectionStyle = .none
                
                enterNameCell.setTextField()
                
                if isMessageLoadList[indexPath.row] == false
                {
                    enterNameCell.loadingAnimate(index: indexPath.row)
                }
                else
                {
                    enterNameCell.showMessageWithNoAnimation()
                }
                
                isMessageLoadList[indexPath.row] = true
                
                return enterNameCell

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
                
            case .normalWithStartHandDrawing:
                
                guard let yourMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                        as? ChatYourMessageCell
                        else {return UITableViewCell() }


                yourMessageCell.setMessage(message: newMessageList[indexPath.row].messageContent)
   

                

                if isMessageLoadList[indexPath.row] == false
                {
                    yourMessageCell.startHandDrawing()
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

