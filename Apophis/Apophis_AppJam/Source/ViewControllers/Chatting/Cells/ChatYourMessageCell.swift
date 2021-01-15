//
//  ChatYourMessageCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/28.
//

import UIKit
import Lottie
import AudioToolbox

class ChatYourMessageCell: UITableViewCell {
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var waitMessageImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageBackgroundImageView: UIImageView!
    
    var check: Bool = false
    
    
    //MARK:- Variable Part

    var loadingView = AnimationView()
    
    //MARK:- Constraint Part

    
    
    //MARK:- Life Cycle Part

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    
    //MARK:- IBAction Part
    
    

    //MARK:- default Setting Function Part
    
    
    
    func setMessage(message : String)
    {
        
        let padding = messageTextView.textContainer.lineFragmentPadding
        messageTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        messageTextView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextView.textColor = .white
        messageTextView.text = message


        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        messageTextView.sizeToFit()
    

        messageTextView.alpha = 0
        waitMessageImageView.alpha = 0
        messageBackgroundImageView.alpha = 0
        

    }
    
    func setSnowBackground()
    {
        NotificationCenter.default.post(name: NSNotification.Name("setSnowBackground"), object: nil)
    }
    func setSeaBackground()
    {
        NotificationCenter.default.post(name: NSNotification.Name("setSeaBackground"), object: nil)
    }
    
    func addEndingComplete()
    {
        NotificationCenter.default.post(name: NSNotification.Name("addEndingComplete"), object: nil)
    }
    
    func setHandDrawing()
    {
        NotificationCenter.default.post(name: NSNotification.Name("setHandDrawing"), object: nil)
    }
    
    func goToTarot(index : Int)
    {

        
        loadingView.frame = waitMessageImageView.bounds
        loadingView.animation = Animation.named("message_loading")
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.play()
        
        waitMessageImageView.addSubview(loadingView)
        
        
        UIView.animateKeyframes(withDuration: 1.5
                                , delay: 0, options: .allowUserInteraction) {
            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/12,animations: {
                    self.waitMessageImageView.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: 10/12, relativeDuration: 1/12, animations: {
                    self.waitMessageImageView.alpha = 0
                    
                })
            
                UIView.addKeyframe(withRelativeStartTime: 11/12, relativeDuration: 1/12, animations: {
                    self.messageTextView.alpha = 1
                    self.messageBackgroundImageView.alpha = 1
                    self.check = true
                })
            
        } completion: { (_) in
            self.loadingView.stop()
            NotificationCenter.default.post(name: NSNotification.Name("aponimousMessageEnd"), object: nil)
        }
        
    }
    
    func startHandDrawing()
    {
        
        self.check = false
        
        
        loadingView.frame = waitMessageImageView.bounds
        loadingView.animation = Animation.named("message_loading")
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.play()
        
        waitMessageImageView.addSubview(loadingView)
        
        

        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .allowUserInteraction) {
            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/12,animations: {
                    
                    self.waitMessageImageView.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: 10/12, relativeDuration: 1/12, animations: {
                    
                    self.waitMessageImageView.alpha = 0
                    
                })
            
                UIView.addKeyframe(withRelativeStartTime: 11/12, relativeDuration: 1/12, animations: {
                    
                    self.messageTextView.alpha = 1
                    self.messageBackgroundImageView.alpha = 1
                    self.check = true
                })
            
        } completion: { (_) in
            
            self.loadingView.stop()
            // 애니메이션이 끝날 때 post를 해주는데, 그 때 object에 index값을 넣어서 쏜다.
            // 여기서 index는 loadingAnimate를 호출할 때 받아온다.
            
            NotificationCenter.default.post(name: NSNotification.Name("startHandDrawing"), object: nil)
            
            
        }
    }

    func loadingAnimate(index : Int, vibrate : Bool)
    {
        
        self.check = false
        
        
        loadingView = AnimationView()
        loadingView.frame = waitMessageImageView.bounds
        loadingView.animation = Animation.named("message_loading")
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.play()
        
        waitMessageImageView.addSubview(loadingView)
        
        

        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .allowUserInteraction) {

            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/12,animations: {
                    self.waitMessageImageView.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: 10/12, relativeDuration: 1/12, animations: {
                    self.waitMessageImageView.alpha = 0
                    
                })
            
                UIView.addKeyframe(withRelativeStartTime: 11/12, relativeDuration: 1/12, animations: {
                    self.messageTextView.alpha = 1
                    self.messageBackgroundImageView.alpha = 1
                    self.check = true
                })
            
        } completion: { (_) in
            self.loadingView.stop()
            // 애니메이션이 끝날 때 post를 해주는데, 그 때 object에 index값을 넣어서 쏜다.
            // 여기서 index는 loadingAnimate를 호출할 때 받아온다.
            NotificationCenter.default.post(name: NSNotification.Name("AponimousMessageEnd"), object: index)

            
            if self.check && vibrate {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
    
    
    func showEndingMessage()
    {
        
        
        loadingView.frame = waitMessageImageView.bounds
        loadingView.animation = Animation.named("message_loading")
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.play()
        
        waitMessageImageView.addSubview(loadingView)
        
        

        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .allowUserInteraction) {
            

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/12,animations: {
                    
                    self.waitMessageImageView.alpha = 1
                    
                })
                
                UIView.addKeyframe(withRelativeStartTime: 10/12, relativeDuration: 1/12, animations: {
                    
                    self.waitMessageImageView.alpha = 0
                    
                })
            
                UIView.addKeyframe(withRelativeStartTime: 11/12, relativeDuration: 1/12, animations: {
                    
                    self.messageTextView.alpha = 1
                    self.messageBackgroundImageView.alpha = 1
                    self.check = true
                })
            
        } completion: { (_) in
            
            self.loadingView.stop()
            // 애니메이션이 끝날 때 post를 해주는데, 그 때 object에 index값을 넣어서 쏜다.
            // 여기서 index는 loadingAnimate를 호출할 때 받아온다.
            
            NotificationCenter.default.post(name: NSNotification.Name("addEndingComplete"), object: nil)
            
            
        }
    }
    
    func showMessageWithNoAnimation()
    {

        loadingView.isHidden = true
        messageTextView.alpha = 1
        messageBackgroundImageView.alpha = 1
    }
    
    
    
    
    
    
    func setMessageRepeat(message : String)
    {
        let padding = messageTextView.textContainer.lineFragmentPadding
        messageTextView.textContainerInset =  UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        messageTextView.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        messageTextView.textColor = .white
        messageTextView.text = message
        messageTextView.translatesAutoresizingMaskIntoConstraints = false

//        messageTextView.sizeToFit()
        
        messageTextView.isScrollEnabled = false
        messageTextView.contentInset = .zero
        
        
        
        messageTextView.alpha = 0
        waitMessageImageView.alpha = 0
        messageBackgroundImageView.alpha = 0

    }
    
    func shutterSound()
    {
        NotificationCenter.default.post(name: NSNotification.Name("shutterSound"), object: nil)
    }
    
    func shutterAnimation()
    {
        
        NotificationCenter.default.post(name: NSNotification.Name("shutterAnimation"), object: nil)
    }
    
    func lightBackground()
    {
        NotificationCenter.default.post(name: NSNotification.Name("lightBackground"), object: nil)
    }

    //MARK:- Function Part


}

//MARK:- extension 부분

