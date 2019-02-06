//
//  SettingVC.swift
//  Befit
//
//  Created by 이충신 on 28/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  1) 설정 VC

import UIKit

class SettingVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    @IBOutlet weak var autoSwitch: UISwitch!
    var autoLogin: Bool?
    var tempID: String?
    var tempPW: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin = userDefault.bool(forKey: "autoLogin")
        print(userDefault.string(forKey: "id"))
        print(userDefault.string(forKey: "pw"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        autoSwitch.isOn = userDefault.bool(forKey: "autoLogin")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func switchBtn(_ sender: UISwitch) {
        autoLogin = sender.isOn
        userDefault.set(autoLogin, forKey: "autoLogin")
        print("자동로그인 \(autoLogin)")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        if autoLogin!{
            
            if let tempid = userDefault.string(forKey: "tempid") {
                print(tempid)
                userDefault.set(tempid, forKey: "id")
                userDefault.removeObject(forKey: "tempid")
            }
            if let temppw = userDefault.string(forKey: "temppw") {
                print(temppw)
                userDefault.set(temppw, forKey: "pw")
                userDefault.removeObject(forKey: "temppw")
            }
           
        }
        else {
            if let id = userDefault.string(forKey: "id"){
                userDefault.set(id, forKey: "tempid")
                userDefault.removeObject(forKey: "id")
            }
            if let pw = userDefault.string(forKey: "pw") {
                userDefault.set(pw, forKey: "temppw")
                userDefault.removeObject(forKey: "pw")
            }
          
            
        }
        
        userDefault.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
            let alert = UIAlertController(title: "로그아웃", message: "메인으로 돌아가시겠습니까?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) {
                _ in
                
                self.userDefault.removeObject(forKey: "token")
                self.userDefault.removeObject(forKey: "id")
                self.userDefault.removeObject(forKey: "pw")
                self.userDefault.synchronize()
                
                self.performSegue(withIdentifier: "GoToLogin", sender: self)
                print("로그아웃 완료!")
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        
        
    
    }

    @IBAction func signoutBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "회원탈퇴", message: "탈퇴 하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in
    
            self.userDefault.removeObject(forKey: "id")
            self.userDefault.removeObject(forKey: "pw")
            self.userDefault.synchronize()
            
            self.signOut()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
        
    }
}

//Mark: - Network Service
extension SettingVC {
    
    func signOut(){
        SignService.shared.signOut { (res) in
            print(res)
            guard let status = res.status else {return}
            switch status {
            case 200:
                self.simpleAlert(res.message!, "회원을 성공적으로 탈퇴하였습니다!", completion: { (res) in
                    self.performSegue(withIdentifier: "GoToLogin", sender: self)
                    print("탈퇴 완료!")
                })
                
            case 401, 500, 600:
                self.simpleAlert(title: "Error", message: res.message!)
            default: return
            }
        }
    }
    
}
