//
//  ExtensionControl.swift
//  Befit
//
//  Created by 박다영 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    public func setCustom(){
    
        self.layer.masksToBounds = true
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
    
    }
    
    public func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}


//MARK: - UTF8 인코딩
extension String {

    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8)
        return text!
    }
}




//MARK: - 정규화
extension String {
    
    public func validationEmail() -> Bool {
        let emailRegex = "^.+@([A-Za-z0-0-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self)
        
    }
    
   public func validationPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return predicate.evaluate(with: self)
    }
    
    
}
