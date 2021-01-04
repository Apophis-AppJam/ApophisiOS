//
//  Day2ViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit

class Day2ViewController: UIViewController {



    //MARK:- IBOutlet Part

    
    
    @IBOutlet weak var messageSendButton: UIButton!
    @IBOutlet weak var messageTextInputView: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var headerTitle: UILabel!
    
    
    //MARK:- Variable Part
    
    //  메세지 리스트
    var messageList : [ChatMessageDataModel] = []
    var isMessageLoadList : [Bool] = []
    
    var isUserEnterAnswer : Bool = false
    
    var isTextFieldEnabled : Bool = false
    

    //MARK:- Constraint Part


    
    
    
    
    
    @IBOutlet weak var messageInputAreaHeightConstraint: NSLayoutConstraint!
    // 메세지 input 창에서 줄바꿈할떄 영역 자체의 height 가 늘어나야 함
    
    @IBOutlet weak var messageInputAreaBottomConstraint: NSLayoutConstraint!
    
    //키보드 올라올떄 조절해야 하는 아래쪽 constraint
    
    
    //MARK:- Life Cycle Part

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setDummyMessage()
        tableViewDefaultSetting()
        addTapAction()
        etcDefaultSetting()
        disableTextField(isEnable: isTextFieldEnabled)
        
        self.navigationController?.navigationBar.isHidden = true


    }

    
    //MARK:- IBAction Part
    
    // 홈버튼 클릭 했을 때

    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때

    
    @IBAction func messageButtonClicked(_ sender: Any) {
        
        
        // 서버 통신이 이 부분에서 붙어야 함
        // 우선은 클라측에서만 뷰 작업 진행중
        

//        let lastIndex =  IndexPath(indexes: [messageList.count - 2,messageList.count - 1])
        let lastIndex =  IndexPath(row: messageList.count - 1, section: 0)
        
        
        messageList.remove(at: messageList.count - 1)
        messageList.append(ChatMessageDataModel(message: messageTextInputView.text,
                                                isLastMessage: false,
                                                isMine: true))
        
        isUserEnterAnswer = true

        chatTableView.reloadRows(at: [lastIndex], with: .none)
        
        messageTextInputView.text = ""
        textViewDidChange(messageTextInputView)
        
        
        
        
    }
    
    //MARK:- default Setting Function Par
    
    
   
    
    
    
    
    func set()
    {
        
        
        

        
        
        
        
        
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    func addObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedUserSelect), name: NSNotification.Name("receivedUserSelect"), object: nil)

    }
    
    
    func tableViewDefaultSetting()
    {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = true
    }

    
    func etcDefaultSetting()
    {
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        messageTextInputView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextInputView.textColor = .init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
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
    
    
    func setDummyMessage() // 서버 붙이기 이전이라 억지로 메세지 주입하는 것 , 서버 나오면 제거하고 서버에서 받아오면 됨
    {
        messageList.append(contentsOf: [
            ChatMessageDataModel(message: "정신없지? 시작하기 전에 물 한 잔 마시고 오는거 어때?", isLastMessage: true, isMine: false),
            ChatMessageDataModel(message: "", isLastMessage: true, isMine: true)
        ])
        
        isMessageLoadList.append(contentsOf: [false,false])
        
        
    }
    
    func setDummyMessage2()
    {
        messageList.append(contentsOf: [
            ChatMessageDataModel(message: "정신없지? 시작하기 전에 물 한 잔 마시고 오는거 어때?", isLastMessage: true, isMine: false),
            ChatMessageDataModel(message: "", isLastMessage: true, isMine: true)
        ])
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
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageList[indexPath.row].isMine == true // 나의 메세지인 경우
        {
            
            if isUserEnterAnswer == true
            {
                guard let myMessageCell =
                        tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageCell", for: indexPath)
                        as? ChatMyMessageCell
                        else {return UITableViewCell() }
                
                myMessageCell.setMessage(message: messageList[indexPath.row].message)
                
                return myMessageCell
            }
            else
            {
                
                
                guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "Day2selectAnswerCell", for: indexPath)
                        as? Day2selectAnswerCell
                        else {return UITableViewCell() }
                
                selectCell.setSelectList(selectList: ["응 마셨어.","딱히, 괜찮아."])
                selectCell.backgroundColor = .init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
                selectCell.selectionStyle = .none
                
                return selectCell
                
            }

        }
        
        else // 아포니머스 메세지인 경우
        {
            guard let yourMessageCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                    as? ChatYourMessageCell
                    else {return UITableViewCell() }
            
            
            yourMessageCell.setMessage(message: messageList[indexPath.row].message)
            
            if isMessageLoadList[indexPath.row] == false
            {
                print("false",isMessageLoadList)
                yourMessageCell.loadingAnimate()
            }
            else
            {
                print("true",isMessageLoadList)
                yourMessageCell.showMessageWithNoAnimation()
            }
            
            isMessageLoadList[indexPath.row] = true
            
            
            return yourMessageCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        cell.transform = CGAffineTransform(translationX: 0, y: 74 * 1.4)
//        cell.alpha = 0
        UIView.animate(
            withDuration: 1,
            delay: 8 * Double(indexPath.row),
//            options: [.curveEaseInOut],
            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//                cell.alpha = 1

            }
        )
//        )
//
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
