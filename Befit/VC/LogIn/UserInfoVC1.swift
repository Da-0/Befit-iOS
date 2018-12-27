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
    
    let yearArray = ["1993", "1994", "1995", "1996"]
    let pickerview = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardSetting()
        setupTap()
        //        setupCompleteButton()
        
        yearTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        yearTF.delegate = self
        initPicker()
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    
    // 글 작성을 완료하는 버튼 설정
    // 인터페이스 빌더에서 네비게이션 바에 버튼이 추가가 안될 경우 (세그로 연결되어 있는 뷰)
    // 아래의 코드작성을 통해 버튼을 추가할 수 있습니다.
    //    func setupCompleteButton() {
    //        let completeBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeWrite))
    //        self.navigationItem.setRightBarButton(completeBtn, animated: true)
    //    }
    
    
    
    // 텍스트필드나 텍스트 뷰의 edit 모드를 해제하기 위한, 즉, 키보드를 내리기 위한 탭 제스처와
    // 이미지 뷰를 탭하면 이미지를 추가할 수 있는 탭 제스처 설정
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        self.view.addGestureRecognizer(viewTap)
        
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
}


//pickerView관련
extension UserInfoVC1: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
    }
    
    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        yearTF.text = yearArray[row]
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearArray[row]
    }
    
}

//MARK: - 키보드 대응
extension UserInfoVC1 {
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
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

