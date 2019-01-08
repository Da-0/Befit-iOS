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
        
            let alert = UIAlertController(title: "로그아웃", message: "메인으로 돌아가시겠습니까?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) {
                _ in
                UserDefaults.standard.removeObject(forKey: "token")
                self.performSegue(withIdentifier: "GoToLogin", sender: self)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        
            print("로그아웃 완료!")
    
    }

    @IBAction func signoutBtn(_ sender: Any) {
        
        print("회원탈탈탈!")
        
    }
}
