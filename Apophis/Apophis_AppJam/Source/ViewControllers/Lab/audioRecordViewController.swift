//
//  audioRecordViewController.swift
//  Apophis_AppJam
//
//  Created by kong on 2021/01/01.
//

import UIKit
import AVFoundation

class audioRecordViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        playButton.isEnabled = false
        stopButton.isEnabled = false
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let docsDir = dirPaths[0] as String
        
        
        //URL 구성
        let soundFilePath = docsDir.appending("/sound.caf")
                let soundFileURL = URL(fileURLWithPath: soundFilePath)
        
        
        //녹음 품질
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
                                      AVEncoderBitRateKey: 16,
                                      AVNumberOfChannelsKey: 2,
                                      AVSampleRateKey: 44100.0] as [String : Any]
        
        // 공유 오디오 세션 인스턴스를 반환 받는다.
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    // 현재 오디오 세션의 카테고리를 정한다. (재생, 녹음)
                    try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                } catch {
                    print("audioSession error: \(error.localizedDescription)")
                }
                
                // audioRecorder 인스턴스 생성
                do {
                    try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings)
                    audioRecorder?.prepareToRecord()
                } catch {
                    print("audioSession Error: \(error.localizedDescription)")
                }
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        if audioRecorder?.isRecording == false {
                playButton.isEnabled = false
                stopButton.isEnabled = true
                audioRecorder?.record()
            
                }
        
    }
    
    @IBAction func playAudio(_ sender: Any) {
        
        if audioRecorder?.isRecording == false {
                   stopButton.isEnabled = true
                   recordButton.isEnabled = false
                   
                   do {
                       try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder!.url)
                       audioPlayer?.delegate = self
                       audioPlayer?.play()
                   } catch {
                       print("audioPlayer error: \(error.localizedDescription)")
                   }
               }
        
    }
    
    
    @IBAction func stopAudio(_ sender: Any) {
        
        stopButton.isEnabled = false
                playButton.isEnabled = true
                recordButton.isEnabled = true
                
                if audioRecorder?.isRecording == true {
                    audioRecorder?.stop()
                } else {
                    audioPlayer?.stop()
                }
        
    }
    
    
    }
    

extension audioRecordViewController: AVAudioPlayerDelegate{
    
    // 재생 종료하면 호출
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            recordButton.isEnabled = true
            stopButton.isEnabled = false
        }
        
        // 디코더 에러 발생하면 호출
        func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
            print("Audio Player Decode Error")
        }
    
}

extension audioRecordViewController: AVAudioRecorderDelegate{
    
    // 시간 제한으로 녹음 종료하면 호출
        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            print("Record Success")
        }
        
        // 녹음중 에러 발생하면 호출
        func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
            print("Audio Record Encode Error")
        }
    
}
