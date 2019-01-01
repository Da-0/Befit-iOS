//
//  SettingVC.swift
//  Befit
//
//  Created by 이충신 on 28/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

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
    
    @IBAction func switchBtn(_ sender: UISwitch) {
        if sender.isOn == true
        {
            print("자동로그인 ON!")
        }
        else{
            print("자동로그인 OFF!")
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("로그아웃!")
        //alert창 띄운다음에 home으로
        
    }

    @IBAction func signoutBtn(_ sender: Any) {
        
        print("회원탈탈탈!")
        
    }
}
