//
//  PWSettingVC.swift
//  Befit
//
//  Created by 박다영 on 30/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class PWSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
