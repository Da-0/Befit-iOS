//
//  UserInfoVC1.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class UserInfoVC1: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayFT: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var ckPasswordTF: UITextField!
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    //create date picker
    let pickerview = UIPickerView()
    
    var yearsTillNow : [String] {
        var years = [String]()
        for i in (1960..<2019).reversed() {
            years.append("\(i)")
        }
        return years
    }
    
    var monthsTillNow : [String] {
        var month = [String]()
        for i in (1..<12).reversed() {
            month.append("\(i)")
        }
        return month
    }
    
    var daysTillNow : [String] {
        var days = [String]()
        for i in (1..<31).reversed() {
            days.append("\(i)")
        }
        return days
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setupCompleteButton()
        
        setKeyboardSetting()
        setupTap()
   
        yearTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        yearTF.delegate = self
        
        monthTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        monthTF.delegate = self
        
        dayFT.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        dayFT.delegate = self
        
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
        
    @objc func completeWrite() {
        // 아래의 guard 문법은 guard 의 조건이 참 이라면 조건을 통과하고 그렇지 않다면 else로 넘어가 예외처리를 하게되는 문법입니다.
        // 여기서는 제목과 내용의 text가 존재하지 않으면 통과하지 못하는 방식으로 사용되었습니다.
        // guard let 구문을 항상 써왔으니 금방 이해하실겁니다!
        guard nameTF.text?.isEmpty != true else {return}
        guard yearTF.text?.isEmpty != true else {return}
        guard monthTF.text?.isEmpty != true else {return}
        guard dayFT.text?.isEmpty != true else {return}
        guard emailTF.text?.isEmpty != true else {return}
        guard passwordTF.text?.isEmpty != true else {return}
        guard ckPasswordTF.text?.isEmpty != true else {return}
    }

    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        self.view.addGestureRecognizer(viewTap)
        
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
}

extension UserInfoVC1: UIPickerViewDelegate, UIPickerViewDataSource {

    func initPicker() {

        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;

        let bar = UIToolbar()
        bar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))

        bar.setItems([doneButton], animated: true)
        yearTF.inputAccessoryView = bar
        yearTF.inputView = pickerview
        
        monthTF.inputAccessoryView = bar
        monthTF.inputView = pickerview
        
        dayFT.inputAccessoryView = bar
        dayFT.inputView = pickerview
    }

    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        yearTF.text = yearsTillNow[row]
        monthTF.text = monthsTillNow[row]
        dayFT.text = daysTillNow[row]
        view.endEditing(true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsTillNow.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearsTillNow[row]
    }

}

//MARK: - 키보드 대응
extension UserInfoVC1: UITextFieldDelegate {
    
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

