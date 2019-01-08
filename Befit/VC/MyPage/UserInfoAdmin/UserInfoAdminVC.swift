//
//  UserInfoAdminVC.swift
//  Befit
//
//  Created by 이충신 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class UserInfoAdminVC: UIViewController {
    
    let ueserDefault = UserDefaults.standard
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
    
    
    @IBOutlet weak var completeBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAddress.delegate = self;
        phoneNumber.delegate = self;
        completeBtn.isEnabled = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.navigationController?.navigationBar.isHidden = false
        network()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.navigationBar.isHidden = false
        
    }
    

    func network(){
        
        UserInfoService.shared.showUserInfo { (res) in
            
            self.userName.text = res.name
            self.birthday.text = res.birthday
            self.userEmail.text = res.email
            self.userGender.text = res.gender
            self.userPW.text = "**********"
            
            guard let post = res.post_number else {return}
            guard let address = res.home_address else {return}
            guard let detail = res.detail_address else {return}
            guard let phone = res.phone else {return}
   
            print(post)
            print(address)
            
            self.addressLabel.text = address
            self.detailAddress.text = detail
            self.phoneNumber.text = phone
            self.postCodeLabel.text = post
            
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
        
      if  postCodeLabel.text != "" && addressLabel.text != ""
            && detailAddress.text != "" && phoneNumber.text != "" {
                self.ueserDefault.set(self.postCodeLabel.text!, forKey: "postCode")
                self.ueserDefault.set(self.addressLabel.text!, forKey: "address")
      }else{
     
        self.ueserDefault.removeObject(forKey: "postCode")
        self.ueserDefault.removeObject(forKey: "address")
        self.ueserDefault.removeObject(forKey: "detailAddress")
        self.ueserDefault.removeObject(forKey: "phoneNumber")
        
//            self.ueserDefault.set("", forKey: "postCode")
//            self.ueserDefault.set("", forKey: "address")
//            self.ueserDefault.set("", forKey: "detailAddress")
//            self.ueserDefault.set("", forKey: "phoneNumber")
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in
          
              //특정회원 통합로그인 정보수정이 일어나는 시점.
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
            
                self.dismiss(animated: true, completion: nil)
            

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


extension UserInfoAdminVC: UITextFieldDelegate {
    
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

}


