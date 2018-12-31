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
    
    @IBOutlet weak var postCodeButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    //우편번호검색 이후 나타남.
    @IBOutlet weak var postCodeLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //저장되어야하는 변수
    @IBOutlet weak var detailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        detailAddress.text = "1111111"
        phoneNumber.text = "2222222"
        
        if let detail = ueserDefault.string(forKey: "detailAddress"),
            let phone = ueserDefault.string(forKey: "phoneNumber"){
                detailAddress.text = detail
                phoneNumber.text = phone
                print(detail)
                print(phone)
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func unwindFromPostCodeSelectionView(_ sender: UIStoryboardSegue) {
        print(#function)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {

        print(ueserDefault.string(forKey: "detailAddress")!)
        print(ueserDefault.string(forKey: "phoneNumber")!)
       self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func completeBtn(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    //우편번호를 수정하기 위해 삭제하는 버튼
    @IBAction func deleteAction(_ sender: Any) {
        
        //버튼은 나타난다.
        postCodeButton.isHidden = false
        
        //나머지는 숨김
        postCodeLabel.isHidden = true
        address1Label.isHidden = true
        deleteBtn.isHidden = true
    }
    

}


extension UserInfoAdminVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("did end")
        ueserDefault.set(detailAddress.text!, forKey: "detailAddress")
        ueserDefault.set(phoneNumber.text!, forKey: "phoneNumber")
        
        
    }

}
