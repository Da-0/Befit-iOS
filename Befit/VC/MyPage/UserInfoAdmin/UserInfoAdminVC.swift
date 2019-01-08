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
        initUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        if let detail = ueserDefault.string(forKey: "detailAddress"),
            let phone = ueserDefault.string(forKey: "phoneNumber"),
            let post = ueserDefault.string(forKey: "postCode"),
            let address = ueserDefault.string(forKey: "address")
            
            {
                detailAddress.text = detail
                phoneNumber.text = phone
                postCodeLabel.text = post
                addressLabel.text = address
                
                postCodeButton.isHidden = true
                postView.isHidden = false
                
            }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func unwindFromPostCodeSelectionView(_ sender: UIStoryboardSegue) {
        print(#function)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    
    //정보수정완료 창 띄우기
    @IBAction func completeBtn(_ sender: Any) {
        
      self.dismiss(animated: true, completion: nil)
        
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
        }
    
        network()
    
    }
    
    
    //가입시 입력한 회원정보 픽스
    func initUserInfo(){
        
        //        userName.text = ""
        //        birthday.text = ""
        //        userEmail.text = ""
        //        userPW.text = ""
        //        userGender.text = ""
        
    }
    
    
    //우편번호를 수정하기 위해 삭제하는 버튼
    @IBAction func deleteAction(_ sender: Any) {
        
        self.ueserDefault.set("", forKey: "postCode")
        self.ueserDefault.set("", forKey: "address")
        
        postCodeButton.isHidden = false
        postView.isHidden = true
        
    }

    
    func network(){
        
        //{
        //    "post_number" : "09952",
        //    "home_address" : "서울시 서대문구 대현동",
        //    "detail_address" : "이화여대 아산공학관",
        //    "phone" : "010-1234-1143"
        //}
        
    }
    

}


extension UserInfoAdminVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        if textField.tag == 0 {
               ueserDefault.set(textField.text!, forKey: "detailAddress")
        }
        if textField.tag == 1 {
               ueserDefault.set(textField.text!, forKey: "phoneNumber")
        }
        
        
    }

}


