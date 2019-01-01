//
//  FindPWVC.swift
//  Befit
//
//  Created by 박다영 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class FindPWVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func okAction(_ sender: Any) {
        let logIn = UIStoryboard.init(name: "LogIn", bundle: nil)
        let settingVC = logIn.instantiateViewController(withIdentifier: "PWSettingVC") as? PWSettingVC
        self.navigationController?.pushViewController(settingVC!, animated: true)
        
    }
    
}
