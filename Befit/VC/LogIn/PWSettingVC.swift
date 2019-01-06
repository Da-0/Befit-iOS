//
//  PWSettingVC.swift
//  Befit
//
//  Created by 박다영 on 30/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class PWSettingVC: UIViewController {

    @IBOutlet weak var newPWTF: UITextField!
    @IBOutlet weak var newPWCKTF: UITextField!
    @IBOutlet weak var disagreeLB: UILabel!
    @IBOutlet weak var passwordNoticeLB: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newPWTF.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)

        setKeyboardSetting()
        
        // 텍스트필드 borderColor
        newPWTF.setCustom()
        newPWCKTF.setCustom()
        
        
        // 텍스트필드 padding
        newPWTF.setLeftPaddingPoints(14)
        newPWCKTF.setLeftPaddingPoints(14)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func passwordRegex(_ sender: Any) {
        if newPWTF.text?.validationPassword() == true {
            newPWCKTF.isEnabled = true
            passwordNoticeLB.textColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5)
        }
        else {
            newPWCKTF.isEnabled = false
            passwordNoticeLB.textColor = #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
            
        }
    }
    
    
    
    @IBAction func passwordCKAction(_ sender: Any) {
        // password 불일치 시
        if newPWTF.text != newPWCKTF.text {
            disagreeLB.isHidden = false
            newPWCKTF.clearButtonMode = .never
            okBtn.isEnabled = false
        }
            // 일치
        else {
            disagreeLB.isHidden = true
            okBtn.isEnabled = true
        }
    }
    @IBAction func okAction(_ sender: Any) {
        if passwordNoticeLB.textColor == #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5) && disagreeLB.isHidden == true{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - 키보드 대응
extension PWSettingVC: UITextFieldDelegate {

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
//        self.view.frame.origin.y = -110
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
//        self.view.frame.origin.y = 0
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
    
    @objc func didEndOnExit(_ sender: UITextField) {
        // 각각 한줄 한줄 input 값을 입력하고, 엔터키를 누르면, 바로 아래의 textfield로 넘어감.
        if sender === newPWTF {
            newPWCKTF.becomeFirstResponder()
        }
        // 리턴을 누르면, accountcheckPassword 필드로 커서가 이동을 한다.
        //accountCheckPassWord.becomeFirstResponder()
        print("exit")
    }
}
//
//extension UITextField {
//
//    func setLeftPaddingPoints(_ amount:CGFloat){
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//
//}
