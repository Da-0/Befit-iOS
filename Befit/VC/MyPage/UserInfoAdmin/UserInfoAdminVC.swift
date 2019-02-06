//
//  UserInfoAdminVC.swift
//  Befit
//
//  Created by 이충신 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  4-1) 통합 회원 정보관리 VC

import UIKit

class UserInfoAdminVC: UIViewController {
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    @IBOutlet weak var completeBtn: UIBarButtonItem!
    var textComplete = false

    //기존의 회원정보
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPW: UILabel!
    @IBOutlet weak var userGender: UILabel!
    
    //우편번호 찾기 버튼
    @IBOutlet weak var postCodeButton: UIButton!
    
    //우편번호검색 이후 나타남.
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var postCodeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //UserDefault에 저장되어야하는 변수
    @IBOutlet weak var detailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAddress.delegate = self;
        phoneNumber.delegate = self;
        completeBtn.isEnabled = false;
        setKeyboardSetting()
        network()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func network(){
        
        //1) 특정회원 통합로그인 기본 정보 보여주기
        UserInfoService.shared.showUserInfo { (res) in
            
            self.userName.text = res.name
            self.birthday.text = res.birthday
            self.userEmail.text = res.email
            self.userGender.text = res.gender
            self.userPW.text = "**********"
            
            guard let post = res.post_number, let address = res.home_address, let detail = res.detail_address, let phone = res.phone else {return}
            
            self.postCodeLabel.text = post
            self.addressLabel.text = address
            self.detailAddress.text = detail
            self.phoneNumber.text = phone
     
            self.postCodeButton.isHidden = true
            self.postView.isHidden = false
        
            }
    }

    @IBAction func unwindFromPostCodeSelectionView(_ sender: UIStoryboardSegue) {
        print(#function)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    
    //정보수정완료 창 띄우기
    @IBAction func completeAction(_ sender: Any) {
    
        let alert = UIAlertController(title: "정보 수정", message: "추가 정보를 등록하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in
          
               //2) 특정회원 통합로그인 추가 정보 등록
                SetUserInfoService.shared.setUserInfo(post: self.postCodeLabel.text!, address: self.addressLabel.text!, detail: self.detailAddress.text!, phone: self.phoneNumber.text!, completion: {[weak self] (res) in
                    guard let `self` = self else {return}
                    
                    if let status = res.status {
                        switch status {
                        case 200:
                            self.dismiss(animated: true, completion: nil)
                        case 401, 500, 600:
                            self.simpleAlert(title: "Error", message: res.message!)
                        default:
                            break
                        }
                    }
                })
        
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    
    }
    
    //우편번호를 수정하기 위해 삭제하는 버튼
    @IBAction func deleteAction(_ sender: Any) {
        postCodeButton.isHidden = false
        postView.isHidden = true
        
    }

}

//MARK: - 키보드 대응 및 뷰 탭
extension UserInfoAdminVC: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField.tag == 0 {
               textComplete = true
        }
        
        if textField.tag == 1 {
            if textComplete && postView.isHidden == false {
                completeBtn.isEnabled = true
            }
        }
        
    }
    
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
    
  
    
 
    
 

}


