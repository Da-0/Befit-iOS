//
//  UserInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.Storyboard
//  4) 회원가입 단계에서 개인 정보를 입력하는 VC

import UIKit

class UserInfoVC3: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    //Name
    @IBOutlet weak var nameTF: UITextField!
    
    //Birthday
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    
    //Email
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var duplicationLB: UILabel!
    
    //PW
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordNoticeLB: UILabel!
    @IBOutlet weak var passwordCkTF: UITextField!
    @IBOutlet weak var correctLB: UILabel!
    var pwCheck: Bool = false
    
    //brand preferences
    var brandIdx1: Int?
    var brandIdx2: Int?

    @IBOutlet weak var nextBtn: UIButton!
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    var gender: String?
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    var yearsTillNow : [String] {
        var years = [String]()
        for i in (1960...2019).reversed() {
            years.append("\(i)년")
        }
        return years
    }
    
    var monthsTillNow : [String] {
        var month = [String]()
        for i in 1...12 {
            month.append("\(i)월")
        }
        return month
    }
    
    var daysTillNow : [String] {
        var days = [String]()
        for i in 1...31 {
            days.append("\(i)일")
        }
        return days
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        initPicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        if pwCheck == false {
            simpleAlert(title: "Error", message: "비밀번호 입력을 확인해 주세요")
        }
        else{
            network()
        }
    }
    
    func network(){
        
        let year = yearTF.text?.dropLast()
        let month = monthTF.text?.dropLast()
        let day = dayTF.text?.dropLast()
        
        let birthday = "\(year!)" + "/" + "\(month!)" + "/" + "\(day!)"
       
        SignUpService.shared.signUp(email: emailTF.text!, pw: passwordCkTF.text!, gender: gender!, name: nameTF.text!, brand1: brandIdx1!, brand2: brandIdx2!, birthday: birthday, completion: {[weak self] (res) in
            guard let `self` = self else {return}
            
            guard let status = res.status else {return}
            
            switch status {
                case 201:
                    self.dismiss(animated: true, completion: nil)
                case 409:
                    self.simpleAlert(title: "Error", message: res.message!)
                    self.duplicationLB.isHidden = false
                    self.duplicationLB.text = "중복"
                case 400,500,600:
                    self.simpleAlert(title: "Error", message: res.message!)
                default: break
            }
        })
    }
    
}


//MARK: - 정규화 작업(TextField)
extension UserInfoVC3 {
    
    
    //이메일 정규화
    @IBAction func emailAction(_ sender: Any) {
        
        guard let check = emailTF.text?.validationEmail() else {return}
        
        duplicationLB.isHidden = check ? true : false
        duplicationLB.text = check ? "" : "형식오류"
    
    }
    
    //비밀번호 정규화
    @IBAction func pwAction(_ sender: Any) {
        
        guard let check = passwordTF.text?.validationPassword() else {return}
        
        passwordCkTF.isEnabled = check ? true : false
        passwordNoticeLB.textColor = check ? #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5) : #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
        pwCheck = check ? true : false
        
    }
    
    //비밀번호 일치여부 확인
    @IBAction func pwCkAction(_ sender: Any) {
        let check = passwordTF.text == passwordCkTF.text
        correctLB.isHidden = false
        correctLB.text = check ? "일치" : "불일치"
        pwCheck = check ? true : false
        
        changeNextBtn()
    }
    
    
    func changeNextBtn(){
        
        guard nameTF.text?.isEmpty != true else {return}
        guard yearTF.text?.isEmpty != true else {return}
        guard monthTF.text?.isEmpty != true else {return}
        guard dayTF.text?.isEmpty != true else {return}
        guard emailTF.text?.isEmpty != true else {return}
        guard passwordTF.text?.isEmpty != true else {return}
        guard passwordCkTF.text?.isEmpty != true else {return}
        
        if pwCheck == true {
            nextBtn.setImage(#imageLiteral(resourceName: "icPurplearrow"), for: .normal)
        }
        else{
            nextBtn.setImage(#imageLiteral(resourceName: "icGrayarrow"), for: .normal)
        }
    }
    
    
}


//MARK: - Picker
extension UserInfoVC3: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func initPicker() {
        setPicekr(pickerView1, yearTF)
        pickerView1.tag = 0
        
        setPicekr(pickerView2, monthTF)
        pickerView2.tag = 1
        
        setPicekr(pickerView3, dayTF)
        pickerView3.tag = 2
    }
    
    func setPicekr( _ pickerView: UIPickerView, _ textField: UITextField) {
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        bar.setItems([doneButton], animated: true)
        
        textField.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        textField.delegate = self;
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        textField.inputAccessoryView = bar
        textField.inputView = pickerView
        
    }
    
    
    @objc func selectedPicker(){
        if yearTF.isFirstResponder{
            let row = pickerView1.selectedRow(inComponent: 0)
            yearTF.text = yearsTillNow[row]
        }
        if monthTF.isFirstResponder{
            let row = pickerView2.selectedRow(inComponent: 0)
            monthTF.text = monthsTillNow[row]
        }
        if dayTF.isFirstResponder{
            let row = pickerView3.selectedRow(inComponent: 0)
            dayTF.text = daysTillNow[row]
        }
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 { return yearsTillNow.count}
        else if pickerView.tag == 1{ return monthsTillNow.count}
        else { return daysTillNow.count}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {return yearsTillNow[row]}
        else if pickerView.tag == 1{return monthsTillNow[row]}
        else {return daysTillNow[row]}
        
    }
    
}



//MARK: - 키보드 대응 및 뷰 탭
extension UserInfoVC3: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
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
        self.view.frame.origin.y = -150
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



