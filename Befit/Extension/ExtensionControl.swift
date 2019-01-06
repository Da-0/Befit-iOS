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
