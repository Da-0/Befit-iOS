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
    
     var keyboardDismissGesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardSetting()
        setupTap()
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
//                         print("\n토근값 저장:" + self.userDefault.string(forKey: "token")!)
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


//MARK: - 키보드 대응 및 뷰 탭
extension LogInVC: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(viewTap)
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
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
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}
