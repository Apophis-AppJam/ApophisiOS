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
    var messageList : [Day1ChatMessageDataModel] = []
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
        addObserver()
        setDummyMessage()
        tableViewDefaultSetting()
        addTapAction()
        etcDefaultSetting()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addImageObserver()
        
        if checkImage {
            let indexPath = IndexPath.init(row: 7, section: 0)
            chatTableView.insertRows(at: [indexPath] , with: .none)
            chatTableView.reloadRows(at: [indexPath] , with: .none)
            print("여기여기여기여기여기여기여기여기여기여기여기여기여기여기여기")
            print(messageList)
            print(pictureImage)
            
        }
    }
    
    
    //MARK:- IBAction Part
    
    // 홈버튼 클릭 했을 때
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // 메세지 전송 버튼 클릭 했을 때
    @IBAction func messageSendButtonClicked(_ sender: Any) {
    }
    
    
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
            Day1ChatMessageDataModel(message: "안녕! 미안 방금 정신없었지?", isLastMessage: false, isMine: false, Day1Func: 0),
            Day1ChatMessageDataModel(message: "그냥, 방금 뉴스 봤어? 지구가 멸망한다길래 아무 번호로나 전화해봤어. 꼭 한 번쯤 해보고 싶었거든", isLastMessage: false, isMine: false, Day1Func: 0),
            Day1ChatMessageDataModel(message: "넌 누구야?", isLastMessage: false, isMine: true, Day1Func: 0),
            Day1ChatMessageDataModel(message: "시끄럽고, 나침반이나 켜보싈?", isLastMessage: false, isMine: false, Day1Func: 0),
            Day1ChatMessageDataModel(message: "", isLastMessage: false, isMine: false, Day1Func: 1),
            Day1ChatMessageDataModel(message: "사진이나 찍으싈?", isLastMessage: false, isMine: false, Day1Func: 0),
            Day1ChatMessageDataModel(message: "", isLastMessage: false, isMine: false, Day1Func: 2)
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
    
    
    private func addImageObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getImage(_ :)), name: .sendImage, object: nil)
    }
    
    @objc func getImage(_ notification: Notification){
        guard let image = notification.userInfo?["image"] as? UIImage? else { return }
        pictureImage = image
        self.messageList.append(contentsOf: [
                                    Day1ChatMessageDataModel(message: "", isLastMessage: false, isMine: false, Day1Func: 5)])
        
        checkImage = true
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
        // 나침반을 부르는 경우
        else if(messageList[indexPath.row].Day1Func == 1){
            guard let ChatButtonCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
                    as? ChatButtonCell
            else {return UITableViewCell() }
            
            ChatButtonCell.viewController = self
            
            ChatButtonCell.index = indexPath.row
            ChatButtonCell.funcNum = messageList[indexPath.row].Day1Func
            
            ChatButtonCell.setChatButton(ImgName: "btnCompass")
            
            return ChatButtonCell
        }
        // 사진 기능을 부르는 경우
        else if(messageList[indexPath.row].Day1Func == 2){
            guard let ChatButtonCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatButtonCell", for: indexPath)
                    as? ChatButtonCell
            else {return UITableViewCell() }
            
            ChatButtonCell.viewController = self
            
            ChatButtonCell.index = indexPath.row
            ChatButtonCell.funcNum = messageList[indexPath.row].Day1Func
            
            ChatButtonCell.setChatButton(ImgName: "btnPhoto")
            
            
            print("끼야아아아아아악",messageList)
            return ChatButtonCell
        }
        
        // 사진을 찍고난 뒤 사진뷰를 불러오는 경우
        else if(messageList[indexPath.row].Day1Func == 5){
            guard let Day1ImageViewCell =
                    tableView.dequeueReusableCell(withIdentifier: "Day1ImageViewCell", for: indexPath)
                    as? Day1ImageViewCell
            else {return UITableViewCell() }
            
            Day1ImageViewCell.pictureImage = pictureImage
            
            return Day1ImageViewCell
        }
        
        else // 아포니머스 메세지인 경우
        {
            guard let yourMessageCell =
                    tableView.dequeueReusableCell(withIdentifier: "ChatYourMessageCell", for: indexPath)
                    as? ChatYourMessageCell
            else {return UITableViewCell() }
            
            yourMessageCell.setMessage(message: messageList[indexPath.row].message)
            
            return yourMessageCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 0, y: 74 * 1.4)
        cell.alpha = 0
        UIView.animate(
            withDuration: 1,
            delay: 1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
                
            }
        )
        
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
