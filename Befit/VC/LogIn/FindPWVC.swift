//
//  FindPWVC.swift
//  Befit
//
//  Created by 박다영 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class FindPWVC: UIViewController {

    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    //create date picker
    let pickerView1 = UIPickerView()
    let pickerview2 = UIPickerView()
    let pickerview3 = UIPickerView()
    
    var yearsTillNow : [String] {
        var years = [String]()
        for i in 1960...2019 {
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
        self.navigationController!.navigationBar.barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        setTF()
        setKeyboardSetting()
        
        //키보드
        setKeyboardSetting()
        
        // 피커
        initPicker()
        
        yearTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        yearTF.delegate = self
        
        monthTF.addTarget(self, action: #selector(selectedPicker2), for: .touchUpInside)
        monthTF.delegate = self
        
        dayTF.addTarget(self, action: #selector(selectedPicker3), for: .touchUpInside)
        dayTF.delegate = self
        
    }
    
    
    func setTF(){
        
        // 텍스트필드 borderColor
        nameTF.setCustom()
        yearTF.setCustom()
        monthTF.setCustom()
        dayTF.setCustom()
        emailTF.setCustom()
        
        
        // 텍스트필드 padding
        nameTF.setLeftPaddingPoints(14)
        yearTF.setLeftPaddingPoints(14)
        monthTF.setLeftPaddingPoints(14)
        dayTF.setLeftPaddingPoints(14)
        emailTF.setLeftPaddingPoints(14)
        
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        if (nameTF.text?.isEmpty)! || (yearTF.text?.isEmpty)! || (monthTF.text?.isEmpty)! || (dayTF.text?.isEmpty)! || (emailTF.text?.isEmpty)! {
              simpleAlert(title: "찾기 실패", message: "모든 항목을 입력해 주세요")
        }
        
        network()
    }
    
    func network(){
        let birthday = yearTF.text! + "/" + monthTF.text! + "/" + dayTF.text!
        
        FindPWService.shared.findPW(email: emailTF.text!, name: nameTF.text!, birthday: birthday, completion: {[weak self] (res) in
            guard let `self` = self else {return}
            if let status = res.status {
                switch status {
                    case 200 :
                        self.userDefault.set(res.data?.idx!, forKey: "idx")
                        let settingVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "PWSettingVC") as! PWSettingVC
                        self.navigationController?.pushViewController(settingVC, animated: true)
                        break
                    case 400, 401, 500, 600 :
                        self.simpleAlert(title: "Error", message: res.message!)
                        break
                    default:
                        break
                }
            }
        })
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - 키보드 대응
extension FindPWVC: UITextFieldDelegate {
    
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
        self.view.frame.origin.y = -110
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


//MARK: - picker
extension FindPWVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func initPicker() {
        
        self.pickerView1.delegate = self;
        self.pickerView1.dataSource = self;
        pickerView1.tag = 0
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        bar.setItems([doneButton], animated: true)
        
        yearTF.inputAccessoryView = bar
        yearTF.inputView = pickerView1
        
        
        
        self.pickerview2.delegate = self;
        self.pickerview2.dataSource = self;
        pickerview2.tag = 1
        
        
        let bar2 = UIToolbar()
        bar2.sizeToFit()
        
        let doneButton2 = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker2))
        bar2.setItems([doneButton2], animated: true)
        
        monthTF.inputAccessoryView = bar2
        monthTF.inputView = pickerview2
        
        
        self.pickerview3.delegate = self;
        self.pickerview3.dataSource = self;
        pickerview3.tag = 2
        
        let bar3 = UIToolbar()
        bar3.sizeToFit()
        
        let doneButton3 = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker3))
        bar3.setItems([doneButton3], animated: true)
        
        dayTF.inputAccessoryView = bar3
        dayTF.inputView = pickerview3
        
    }
    
    @objc func selectedPicker(){
        let row = pickerView1.selectedRow(inComponent: 0)
        yearTF.text = yearsTillNow[row]
        view.endEditing(true)
    }
    
    @objc func selectedPicker2(){
        let row2 = pickerview2.selectedRow(inComponent: 0)
        monthTF.text = monthsTillNow[row2]
        view.endEditing(true)
    }
    
    @objc func selectedPicker3(){
        let row3 = pickerview3.selectedRow(inComponent: 0)
        dayTF.text = daysTillNow[row3]
        view.endEditing(true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return yearsTillNow.count
        }
        else if pickerView.tag == 1{
            return monthsTillNow.count
        }
        else {
            return daysTillNow.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return yearsTillNow[row]
        }
        else if pickerView.tag == 1{
            return monthsTillNow[row]
        }
        else {
            return daysTillNow[row]
        }
        
    }
    
}

