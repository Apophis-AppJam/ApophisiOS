//
//  GIFImageView.swift
//  GIFImageView
//
//  Created by Med Hajlaoui on 09/03/2017.
//  Copyright © 2017 Med. All rights reserved.
//

import UIKit
import ImageIO


@IBDesignable
class GIFImageView: UIImageView {
    @IBInspectable public var animatedImage: String = ""
    @IBInspectable public var repeatCount: Int = 0 // forever
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let animation = UIImage.animatedImage(named: self.animatedImage) {
            self.animationImages = animation.images
            self.animationDuration = animation.duration
            self.animationRepeatCount = self.repeatCount
            self.image = animation.images?.last
            self.startAnimating()
        }
    }
}

extension UIImage {
    
    public class func animatedImage(withData: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(withData as CFData, nil) else {
            return nil
        }
        
        return UIImage.animatedImage(cgSource: source)
    }
    
    public class func animatedImage(withUrl: String) -> UIImage? {
        guard let bundleURL = URL(string: withUrl) else {
            return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return animatedImage(withData: imageData)
    }
    
    public class func animatedImage(named: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: named, withExtension: "gif") else {
                return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return animatedImage(withData: imageData)
    }
    
    fileprivate class func delay(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 1.0
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as? Double ?? 0
        
        if delay < 0.0 {
            delay = 1.0
        }
        
        return delay
    }
    
    fileprivate class func pair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        var r: Int
        while true {
            r = a! % b!
            
            if r == 0 {
                return b!
            } else {
                a = b
                b = r
            }
        }
    }
    
    fileprivate class func vector(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var p = array[0]
        
        for val in array {
            p = UIImage.pair(val, p)
        }
        
        return p
    }
    
    fileprivate class func animatedImage(cgSource: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(cgSource)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(cgSource, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delay(Int(i), source: cgSource)
            delays.append(Int(delaySeconds * 1000.0))
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = vector(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}
