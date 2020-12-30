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
    @IBOutlet weak var backgroundImageFirst: UIImageView!
    
    //MARK:- Variable Part
    
    //  메세지 리스트
    var messageList : [ChatMessageDataModel] = []
    

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
        
        self.navigationController?.navigationBar.isHidden = true


    }

    
    //MARK:- IBAction Part
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // 홈버튼 클릭 했을 때


    
    @IBAction func messageSendButtonClicked(_ sender: Any) {
    }
    // 메세지 전송 버튼 클릭 했을 때


    
    //MARK:- default Setting Function Part

    
    func addObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    func tableViewDefaultSetting()
    {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
    }

    
    func etcDefaultSetting()
    {
        headerTitle.font = UIFont.gmarketFont(weight: .Medium, size: 18)
        messageTextInputView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextInputView.textColor = .init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        messageTextInputView.delegate = self
    }
    
    
    func setDummyMessage() // 서버 붙이기 이전이라 억지로 메세지 주입하는 것 , 서버 나오면 제거하고 서버에서 받아오면 됨
    {
        messageList.append(contentsOf: [
            ChatMessageDataModel(message: "오늘은 어때? 이번에는 좋아하는 향이 있으면 뿌리고 얘기해볼까?", isLastMessage: false, isMine: false),
            ChatMessageDataModel(message: "오늘 여행길에 본 풍경이야! 되게 예쁘지?", isLastMessage: false, isMine: false),
            ChatMessageDataModel(message: "그런데, 길을 걷다가 어떤 사람들이 나를 멈춰세우더라?", isLastMessage: false, isMine: false),
            ChatMessageDataModel(message: "그러더니, 자기들 손목을 묶어달라는거야.", isLastMessage: false, isMine: false)
        ])
        
    }
    
    
    //MARK:- Function Part

    //키보드 액션 부분
    
    
    func addTapAction()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        
        view.addGestureRecognizer(tap)

    }
    
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
    


}


//MARK:- extension 부분



extension Day3ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension Day3ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageList[indexPath.row].isMine == true // 나의 메세지인 경우
        {
            guard let myMessageCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatMyMessageCell", for: indexPath)
                    as? ChatMyMessageCell
                    else {return UITableViewCell() }
            
            myMessageCell.setMessage(message: messageList[indexPath.row].message)
            myMessageCell.backgroundColor = .clear
            return myMessageCell
        }
        
        else // 아포니머스 메세지인 경우
        {
            guard let yourMessageCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                    as? ChatYourMessageCell
                    else {return UITableViewCell() }
            
            yourMessageCell.setMessage(message: messageList[indexPath.row].message)
            
            yourMessageCell.backgroundColor = .none
            
            return yourMessageCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 0, y: 74 * 1.4)
        cell.alpha = 0
        UIView.animate(
            withDuration: 1,
            delay: 2 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1

            }
        )
        
        UIView.animateKeyframes(withDuration: 10, delay: 0,options: [], animations: {
            

            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {

                tableView.backgroundColor = .none
                cell.backgroundColor = UIColor.clear
                cell.contentView.backgroundColor = UIColor.clear
                self.headerView.backgroundColor = .none
                self.massageInputAreaView.backgroundColor = .none
                
                    })

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15, animations: {

                        self.backgroundImageFirst.alpha = 0

            })
            
                
        }, completion: {_ in
            
            let uvc = self.storyboard!.instantiateViewController(withIdentifier: "DrawingViewController")
            
            uvc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

            uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            

            self.present(uvc, animated: true)
            
        })

        

        
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
            self.messageSendButton.setBackgroundImage(UIImage(named: "chatIcSendUnactivate"), for: .normal)
            
            textView.textColor = UIColor.init(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        }
    }
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == self.messageTextInputView && textView.text != ""
        {
            self.messageTextInputView.sizeToFit()
            
            self.messageSendButton.isEnabled = true
            self.messageSendButton.setBackgroundImage(UIImage(named: "chatIcSendActivate"), for: .normal)
            
            
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