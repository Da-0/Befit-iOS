//
//  UIImageView+Extensions.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                //Kingfisher를 사용하여 이미지 적용.
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
    
    public func imageFromUrl2(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                //Kingfisher를 사용하여 이미지 적용.
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil) { (image, error, cashType, imageUrl) in
                    self.image = image?.cropBottomImage()
                }
            }
        } else {
            self.image = defaultImg
        }
    }
    
   
}


extension UIImage {
    
    public func cropBottomImage() -> UIImage {
        let height = CGFloat(self.size.height / 15)
        let rect = CGRect(x: 0, y: height, width: self.size.width, height: self.size.height - 2 * height)
        return cropImage(image: self, toRect: rect)
    }
    
    
    public func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
}
