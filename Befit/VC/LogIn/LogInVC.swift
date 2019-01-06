//
//  LogInVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, APIManager {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    
    let userDefault = UserDefaults.standard
    @IBOutlet weak var switchBtn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchBtn.transform = CGAffineTransform(scaleX: 0.63, y: 0.63)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTF.text = ""
        pwTF.text = ""
    }
    
    @IBAction func loginBtn(_ sender: Any){
        
        if (emailTF.text?.isEmpty)! || (pwTF.text?.isEmpty)! {
            simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해 주세요")
            return
        }
        
        network()
    }
    
    
    func network(){
        
        LoginService.shared.login(email: emailTF.text!, password: pwTF.text!, completion: {[weak self] (res) in
            guard let `self` = self else {return}
           
            if let status = res.status {
                switch status {
                    case 200 :
                         self.userDefault.set(res.data?.token!, forKey: "token")
                         print("토근값 저장:" + self.userDefault.string(forKey: "token")!)
                         let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideStart")
                         self.present(mainVC, animated: true, completion: nil)
                         break
                    case 400:
                        self.simpleAlert(title: "Error", message: "아이디 또는 패스워드가 일치하지 않습니다!")
                    case 401, 500, 600 :
                        self.simpleAlert(title: "Error", message: res.message!)
                        break
                    default:
                        break
                }
            }
        })
        
    }
    
    @IBAction func unwind(_ sender: UIStoryboardSegue){
        
    }
    


}
