//
//  FindPWVC.swift
//  Befit
//
//  Created by 박다영 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.storyboard
//  1-1) 비밀번호 찾기 VC

import UIKit

class FindPWVC: UIViewController {

    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    var keyboardDismissGesture : UITapGestureRecognizer?
    @IBOutlet weak var noticeLB: UILabel!
    
    //create date picker
    let pickerView1 = UIPickerView()
    let pickerview2 = UIPickerView()
    let pickerview3 = UIPickerView()
    
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
        self.navigationController!.navigationBar.barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        setKeyboardSetting()
        initPicker()
        
    }
    

    
    @IBAction func okAction(_ sender: Any) {
        
        if (nameTF.text?.isEmpty)! || (yearTF.text?.isEmpty)! || (monthTF.text?.isEmpty)! || (dayTF.text?.isEmpty)! || (emailTF.text?.isEmpty)! {
              simpleAlert(title: "찾기 실패", message: "모든 항목을 입력해 주세요")
        }
        
        network()
    }
    
    
    func network(){
        
        let year = yearTF.text?.dropLast()
        let month = monthTF.text?.dropLast()
        let day = dayTF.text?.dropLast()
        
        let birthday = "\(year!)" + "/" + "\(month!)" + "/" + "\(day!)"
        
        FindPWService.shared.findPW(email: emailTF.text!, name: nameTF.text!, birthday: birthday, completion: {[weak self] (res) in
            guard let `self` = self else {return}
            
            if let status = res.status {
                switch status {
                    case 200 :
                        let settingVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "PWSettingVC") as! PWSettingVC
                        settingVC.userIdx = res.data?.idx
                        self.navigationController?.pushViewController(settingVC, animated: true)
                        break
                    case 400 :
                        self.noticeLB.isHidden = false
                    case 401, 500, 600 :
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


//MARK: - picker
extension FindPWVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func initPicker() {
        setPicekr(pickerView1, yearTF)
        pickerView1.tag = 0
        
        setPicekr(pickerview2, monthTF)
        pickerview2.tag = 1
        
        setPicekr(pickerview3, dayTF)
        pickerview3.tag = 2
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
            let row = pickerview2.selectedRow(inComponent: 0)
            monthTF.text = monthsTillNow[row]
        }
        if dayTF.isFirstResponder{
            let row = pickerview3.selectedRow(inComponent: 0)
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





