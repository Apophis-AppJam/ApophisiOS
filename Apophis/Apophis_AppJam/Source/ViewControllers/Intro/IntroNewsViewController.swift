//
//  IntroNewsViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/29.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class IntroNewsViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    @IBOutlet weak var tempTitle1: UILabel!
    @IBOutlet weak var tempTitle2: UILabel!
    @IBOutlet weak var tempTitle3: UILabel!
    
    
    @IBOutlet weak var sampleView: UIView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    //MARK:- Variable Part

    let avPlayerViewController = AVPlayerViewController()
    var avPlayer : AVPlayer?
    
    var newsCommentList : [NewsCommentDataModel] = []
    var newsCommentTempList : [NewsCommentDataModel] = [] // 실제 배열에 넣기 전에 임시 저장하는 곳
    var commentCount = 0 // 100개 되면 종료하기

    //MARK:- Constraint Part

    //MARK:- Life Cycle Part
    /// 앱의 Life Cycle 부분을 선언합니다
    /// ex) override func viewWillAppear() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDummyComment()

        playVideo()
        defaultViewSetting()
        defaultTableViewSetting()
        
        

    }
    
    func playVideo(){
        
        let filepath: String? = Bundle.main.path(forResource: "sampleVideo", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        
        self.avPlayer = AVPlayer(url: fileURL)
        self.avPlayerViewController.player = self.avPlayer
        self.avPlayerViewController.view.frame =
                    CGRect(x: sampleView.frame.origin.x,
                           y: sampleView.frame.origin.y,
                           width: sampleView.bounds.width,
                           height: sampleView.bounds.height)
                           
        avPlayerViewController.showsPlaybackControls = false
        sampleView.addSubview(avPlayerViewController.view)

        self.avPlayerViewController.player?.play()



    }
    
    
    
    
    //MARK:- IBAction Part

    
    //MARK:- default Setting Function Part
    
    func defaultViewSetting()
    {
        self.navigationController?.navigationBar.isHidden = true
        tempTitle1.font = UIFont.gmarketFont(weight: .Medium, size: 17)
        tempTitle2.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        tempTitle3.font = UIFont.gmarketFont(weight: .Medium, size: 14)
    }
    
    func defaultTableViewSetting()
    {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.backgroundColor = .clear
        chatTableView.separatorStyle = .none
    }
    
    
    func setDummyComment()
    {
        newsCommentTempList.append(contentsOf: [
            NewsCommentDataModel(message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "앜ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", time: "오후 2:56", nickname: "팬더지훈"),
            NewsCommentDataModel(message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 재밌다", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "이거 재방 언제해주죠??", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "하 내일 주말이네 ㅠㅠㅠ", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "?????", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "방송국 해킹당한건가??", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "뭐지 저건?!", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            NewsCommentDataModel(message: "웅성 웅성", time: "오후 2:56", nickname: "조작된농촌"),
            NewsCommentDataModel(message: "저게 뭐야?!", time: "오후 2:56", nickname: "오이영재"),
            NewsCommentDataModel(message: "????", time: "오후 2:56", nickname: "최강선아"),
            NewsCommentDataModel(message: "실제 상황이에요??", time: "오후 2:56", nickname: "큐티진수"),
            NewsCommentDataModel(message: "와 미쳤어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "ㅠㅠㅠㅠㅠㅠ", time: "오후 2:57", nickname: "지존세화"),
            NewsCommentDataModel(message: "어떻게 하는거에요??", time: "오후 2:57", nickname: "천무슈염"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "배고프다", time: "오후 2:57", nickname: "빵떡지훈"),
            NewsCommentDataModel(message: "?????????", time: "오후 2:57", nickname: "솝트"),
            
        ])
        chatTableView.reloadData()
        
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { timer in
            

            
            
            self.newsCommentList.append(self.newsCommentTempList[self.commentCount])
            self.chatTableView.reloadData()
            self.chatTableView.scrollToBottom()

            self.commentCount += 1
            
            if self.commentCount == self.newsCommentTempList.count // temp 배열 떨어질때까지 하나씩 추가해봅시다
            {
                timer.invalidate()
            }
            

        }
    }

    
    //MARK:- Function Part



}


//MARK:- extension 부분


extension IntroNewsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension IntroNewsViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCommentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let commentCell = tableView.dequeueReusableCell(withIdentifier: "IntroNewsCommentCell") as? IntroNewsCommentCell else {return UITableViewCell() }
        
        
        commentCell.setMessage(time: newsCommentList[indexPath.row].time,
                               name: newsCommentList[indexPath.row].nickname,
                               message: newsCommentList[indexPath.row].message)
        
        commentCell.backgroundColor = .clear
        
        return commentCell
         
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

//        cell.transform = CGAffineTransform(translationX: 0, y: -37 * 1.4)
//        cell.alpha = 0
//        UIView.animate(
//            withDuration: 0.3,
//            delay: 1 * Double(indexPath.row),
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//                cell.alpha = 1
//                self.chatTableView.scrollToBottomRow()
//
//            }
//        )
//

        
    }
    
    
    
}
