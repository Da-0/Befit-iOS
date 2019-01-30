//
//  PWSettingVC.swift
//  Befit
//
//  Created by 박다영 on 30/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.storyboard
//  1-2) 계정 비밀번호 재설정 VC

import UIKit

class PWSettingVC: UIViewController {

    @IBOutlet weak var newPWTF: UITextField!
    @IBOutlet weak var newPWCKTF: UITextField!
    @IBOutlet weak var disagreeLB: UILabel!
    @IBOutlet weak var passwordNoticeLB: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    var userIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPWTF.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)

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
        if let check = newPWTF.text?.validationEmail() {
//          newPWCKTF.isEnabled = check ? true : false
            passwordNoticeLB.textColor = check ? #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5) : #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
        }
    }
    
    @IBAction func passwordCKAction(_ sender: Any) {
        
        // password 불일치 시
        if newPWTF.text != newPWCKTF.text {
            disagreeLB.isHidden = false
            okBtn.isEnabled = false
        }
        // 일치
        else {
            disagreeLB.isHidden = true
            okBtn.isEnabled = true
        }
        
    }
    
    
    @IBAction func okAction(_ sender: Any) {
        
        if (newPWTF.text?.isEmpty)! || (newPWCKTF.text?.isEmpty)! {
            simpleAlert(title: "경고", message: "모든 항목을 입력해 주십시오.")
        }
        if passwordNoticeLB.textColor != #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5) && !disagreeLB.isHidden {
            simpleAlert(title: "경고", message: "패스워드가 불일치 합니다.")
        }
        
        network()
    }
    
    
    func network(){
    
        PWSettingService.shared.setPW(idx: userIdx!, pw: newPWTF.text!, completion:
            {[weak self] (res) in
            guard let `self` = self else {return}
            if let status = res.status {
                switch status {
                    case 200:
                      self.dismiss(animated: true, completion: nil)
                    case 204, 500, 600:
                        self.simpleAlert(title: "Error", message: res.message!)
                default:
                    break
                }
            }
        })
    
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
    
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if sender === newPWTF {
            newPWCKTF.becomeFirstResponder()
        }
    }
}

