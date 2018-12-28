//
//  UserInfoVC2.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class UserInfoVC2: UIViewController {
    
    @IBOutlet weak var womanImg: UIButton!
    @IBOutlet weak var manImg: UIButton!
    var selected: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //성별 선택시 이미지 변환
    @IBAction func womanBtn(_ sender: Any) {
        
        if !womanImg.isSelected {
            womanImg.isSelected = true
            womanImg.setImage(#imageLiteral(resourceName: "icWomanTouch"), for: .selected)
            manImg.setImage(#imageLiteral(resourceName: "icManNotouch"), for: .selected)
            manImg.isSelected = false
        }
        else{
            womanImg.isSelected = false
            womanImg.setImage(#imageLiteral(resourceName: "icWomanNotouch"), for: .selected)
        }
       
    }
    
    @IBAction func manBtn(_ sender: Any) {
        
        
        if !manImg.isSelected {
            manImg.isSelected = true
            manImg.setImage(#imageLiteral(resourceName: "icManTouch"), for: .selected)
            womanImg.setImage(#imageLiteral(resourceName: "icWomanNotouch"), for: .selected)
            womanImg.isSelected = false
        }
        else{
            manImg.isSelected = false
            manImg.setImage(#imageLiteral(resourceName: "icManNotouch"), for: .selected)
        }
    }
    

}
