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
        
        
        
        let time = DispatchTime.now() + .seconds(20)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            
            self.avPlayerViewController.player?.pause()
            guard let phoneVC = self.storyboard?.instantiateViewController(identifier: "IntroPhoneRingViewController") as? IntroPhoneRingViewController else {return}
            
            phoneVC.modalTransitionStyle = .crossDissolve
            phoneVC.modalPresentationStyle = .fullScreen
            
            self.present(phoneVC, animated: true, completion: nil)
        }

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
        tempTitle1.font = UIFont.gmarketFont(weight: .Medium, size: 16)
        tempTitle2.font = UIFont.gmarketFont(weight: .Medium, size: 12)
        tempTitle3.font = UIFont.gmarketFont(weight: .Medium, size: 12)
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
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:56", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:56", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:56", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:56", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:56", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:57", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:57", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:57", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:57", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:57", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:57", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:57", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:57", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:57", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:57", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:57", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:57", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:57", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:57", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:57", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재"),
            
            NewsCommentDataModel(message: "커퓌한잔할래요?", time: "오후 2:58", nickname: "콩이"),
            NewsCommentDataModel(message: "제주도 방어회는 먹고 죽고 싶어", time: "오후 2:58", nickname: "틱톡수연"),
            NewsCommentDataModel(message: "바다 한번 못보고 이렇게 가는구나", time: "오후 2:58", nickname: "버디"),
            NewsCommentDataModel(message: "죽을 때는 버건디 옷을 입어야겠다", time: "오후 2:58", nickname: "버건디두"),
            NewsCommentDataModel(message: "아포피스 맞이 라이브 컨텐츠 구독과 좋아요~", time: "오후 2:58", nickname: "진수"),
            NewsCommentDataModel(message: "지구의 삶은 짧아도 예술은 영원해!", time: "오후 2:58", nickname: "쥬똄 킴"),
            NewsCommentDataModel(message: "앞머리 어제 잘랐는데 길기도 전에 죽네!", time: "오후 2:58", nickname: "세화"),
            NewsCommentDataModel(message: "헉 죽기 전에 얼른 자퇴해야지", time: "오후 2:58", nickname: "봉쥬르 안"),
            NewsCommentDataModel(message: "마지막에 사람이 변한다고 하지... 오이를 아삭아삭..", time: "오후 2:58", nickname: "오이영재"),
            NewsCommentDataModel(message: "죽기전에 흑발을 할까 말까", time: "오후 2:58", nickname: "성림성"),
            NewsCommentDataModel(message: "에브리 바디 루프탑 파리~~~", time: "오후 2:58", nickname: "연수정수연"),
            NewsCommentDataModel(message: "우물쭈물 살다가 이럴 줄 알았지", time: "오후 2:58", nickname: "다니엘 최"),
            NewsCommentDataModel(message: "나는 죽어도 아름다운 나의 사랑은 계속될거야", time: "오후 2:58", nickname: "레고가좋아현"),
            NewsCommentDataModel(message: "나긋나긋 asmr (지구멸망.ver)", time: "오후 2:58", nickname: "서나선아"),
            
            NewsCommentDataModel(message: "아직 해리포터 다 못 봤는데 ㅠㅠㅠ", time: "오후 2:58", nickname: "혜니포터"),
            NewsCommentDataModel(message: "나는 사과나무를 한그루 심겠어", time: "오후 2:58", nickname: "럭키디두"),
            NewsCommentDataModel(message: "최준은 내꺼야 다 건들지마", time: "오후 2:58", nickname: "최준♥유경"),
            NewsCommentDataModel(message: "아직 틱톡 못찍었는데 망했다ㅜ", time: "오후 2:58", nickname: "가토수연"),
            NewsCommentDataModel(message: "거짓말이겠지..", time: "오후 2:58", nickname: "폭풍영재"),
            NewsCommentDataModel(message: "5252~다들 호들갑 떨지 말라구~", time: "오후 2:58", nickname: "52영재")
            
            
            
            

            
        ])
        chatTableView.reloadData()
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            

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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 28
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
                               message: newsCommentList[indexPath.row].message, imageIndex: indexPath.row % 5)
        
        commentCell.backgroundColor = .clear
        
        return commentCell
         
    }
    
    
    
    

    
}
