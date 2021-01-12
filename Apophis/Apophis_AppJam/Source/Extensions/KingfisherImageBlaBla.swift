//
//  KingfisherImageBlaBla.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/12.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    
    
    
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            if let image = image { // 만약 캐시에 이미지가 존재한다면
                self.image = image // 바로 이미지를 셋한다.
            } else {
                if urlString != ""
                {
                    
                    let url = URL(string: urlString) // 캐시가 없다면
                    let resource = ImageResource(downloadURL: url!, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource,options: [.transition(.fade(0.5))])
                }

                
            }
        }
    }
    
    
    
    func setThumbnailImage(with urlString: String) {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 512 * 512 * 100
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            
            
            
            if let image = image { // 만약 캐시에 이미지가 존재한다면
                let thumbnailImage = image.resized(withPercentage: 0.4)
                
                
                self.image = thumbnailImage // 바로 이미지를 셋한다.
                
            } else {
                if urlString != ""
                {
                    
                    let url = URL(string: urlString) // 캐시가 없다면
                    let resource = ImageResource(downloadURL: url!, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                     
                  
                    
                    
                    self.kf.setImage(with: resource) // 이미지를 셋한다.
                    
          
                }

                
            }
        }
    }
    
    
    func setProfileImage(with urlString: String){
        
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            
            
            self.layer.borderWidth=1.0
            self.layer.masksToBounds = false
            self.layer.borderColor = .init(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            self.layer.cornerRadius = self.frame.size.height/2
            self.clipsToBounds = true
            
            if urlString == ""
            {
                self.image = UIImage(named: "classIcProfile")
            }
            else
            {
                if let image = image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    let url = URL(string: urlString) // 캐시가 없다면
                    let resource = ImageResource(downloadURL: url!, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource) // 이미지를 셋한다.
                }
            }
            

        }
    } // 프로필 사진은 원으로 깎아야 한다
    
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
