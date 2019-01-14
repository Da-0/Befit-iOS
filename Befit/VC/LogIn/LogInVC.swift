//
//  LogInVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.Storyboard
//  0)아이디와 패스워드를 입력하는 뷰

import UIKit

class LogInVC: UIViewController, APIManager {
    
    let userDefault = UserDefaults.standard

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var switchBtn: UISwitch!
    
     var keyboardDismissGesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
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
                        guard let token = res.data?.token else { return}
                         self.userDefault.set(token, forKey: "token")
                         let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideStart")
                         self.present(mainVC, animated: true, completion: nil)
                         break
                    
                    case 400:
                        self.simpleAlert(title: "Error", message: "아이디 또는 패스워드가 일치하지 않습니다!")
                    break
                    
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


    @IBAction func autoLogin(_ sender: UISwitch) {
        if sender.isOn {
            print("자동로그인 켰습니다!")
        }
        else{
            print("자동로그인 껐습니다!")
        }
    }
    
    
    
    
    
}


//MARK: - 키보드 대응 및 뷰 탭
extension LogInVC: UITextFieldDelegate, UIGestureRecognizerDelegate {
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        self.view.frame.origin.y = -120
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        self.view.frame.origin.y = 0
    }

    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    

}
