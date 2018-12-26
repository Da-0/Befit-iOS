//
//  UserInfoVC1.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class UserInfoVC1: UIViewController {

    @IBOutlet weak var yearTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearTF.addTarget(self, action: #selector(yearClicked), for: .touchUpInside)
        yearTF.delegate = self
       
    }
    
    @objc
    func yearClicked(){
        
        
        yearTF.text = " "
    }


}

extension UserInfoVC1: UITextFieldDelegate {
    
}

extension UserInfoVC1: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    
}
