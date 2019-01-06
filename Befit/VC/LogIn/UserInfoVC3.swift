import UIKit

class UserInfoVC3: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var duplicationLB: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordNoticeLB: UILabel!
    @IBOutlet weak var passwordCkTF: UITextField!
    @IBOutlet weak var correctLB: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    //create date picker
    let pickerView1 = UIPickerView()
    let pickerview2 = UIPickerView()
    let pickerview3 = UIPickerView()
    
    var yearsTillNow : [String] {
        var years = [String]()
        for i in (1960..<2019).reversed() {
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
        setupTap()
        setupTF()
        
        yearTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        yearTF.delegate = self
        
        monthTF.addTarget(self, action: #selector(selectedPicker2), for: .touchUpInside)
        monthTF.delegate = self
        
        dayTF.addTarget(self, action: #selector(selectedPicker3), for: .touchUpInside)
        dayTF.delegate = self
        
        initPicker()
        nextBtn.addTarget(self, action: #selector(completeWrite), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        // completeWrite()
        //self.dismiss(animated: true, completion: nil)
    }
    
    @objc func completeWrite() {
        
        // 아래의 guard 문법은 guard 의 조건이 참 이라면 조건을 통과하고 그렇지 않다면 else로 넘어가 예외처리를 하게되는 문법입니다.
        // 여기서는 제목과 내용의 text가 존재하지 않으면 통과하지 못하는 방식으로 사용되었습니다.
        // guard let 구문을 항상 써왔으니 금방 이해하실겁니다!
        
        let pwCheck: Bool = passwordTF.text == passwordCkTF.text
        let pwNotice: Bool = passwordNoticeLB.textColor == #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5)
    
        guard nameTF.text?.isEmpty != true else {return}
        guard yearTF.text?.isEmpty != true else {return}
        guard monthTF.text?.isEmpty != true else {return}
        guard dayTF.text?.isEmpty != true else {return}
        guard emailTF.text?.isEmpty != true else {return}
        guard passwordTF.text?.isEmpty != true else {return}
        guard passwordCkTF.text?.isEmpty != true else {return}
        guard pwCheck == true else {return}
        guard duplicationLB.isHidden == true else {return}
        guard pwNotice == true else {return}
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    // 이메일 정규화
    @IBAction func emailAction(_ sender: Any) {
        if emailTF.text?.validationEmail() == true {
            duplicationLB.text?.removeAll()
        }
        else {
            duplicationLB.isHidden = false
            duplicationLB.text?.removeAll()
            duplicationLB.text?.append("형식오류")
        }

    }
    
    // 비밀번호 정규화
    @IBAction func pwAction(_ sender: Any) {
        if passwordTF.text?.validationPassword() == true {
            passwordCkTF.isEnabled = true
            passwordNoticeLB.textColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5)
        }
        else {
            passwordCkTF.isEnabled = false
            passwordNoticeLB.textColor = #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
            
        }
        
    }
    
    // 비밀번호 확인
    @IBAction func pwCkAction(_ sender: Any) {
        // password 불일치 시
        if passwordTF.text != passwordCkTF.text {
            correctLB.isHidden = false
            correctLB.text?.removeAll()
            correctLB.text?.append("불일치")
            passwordCkTF.clearButtonMode = .never
            
        }
            // 일치
        else {
            correctLB.isHidden = false
            correctLB.text?.removeAll()
            correctLB.text?.append("일치")
        }
        
    }
    
    func setupTF(){
        
        // 텍스트필드 borderColor
        nameTF.setCustom()
        yearTF.setCustom()
        monthTF.setCustom()
        dayTF.setCustom()
        emailTF.setCustom()
        passwordTF.setCustom()
        passwordCkTF.setCustom()
        
        
        // 텍스트필드 padding
        nameTF.setLeftPaddingPoints(14)
        yearTF.setLeftPaddingPoints(14)
        monthTF.setLeftPaddingPoints(14)
        dayTF.setLeftPaddingPoints(14)
        emailTF.setLeftPaddingPoints(14)
        passwordTF.setLeftPaddingPoints(14)
        passwordCkTF.setLeftPaddingPoints(14)
        
        passwordCkTF.delegate = self;
        
    }
    
 
    
    func setupTap() {
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(viewTap)
        
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    
    
}


//MARK: - picker
extension UserInfoVC3: UIPickerViewDelegate, UIPickerViewDataSource {
    
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



//MARK: - 키보드 대응
extension UserInfoVC3: UITextFieldDelegate {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.view.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.tag == 6 && duplicationLB.isHidden == true && passwordNoticeLB.textColor == #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5) && passwordTF.text == passwordCkTF.text){
            print("helloworld!")
            nextBtn.setImage(#imageLiteral(resourceName: "icPurplearrow"), for: .normal)
        }
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

//MARK: - 정규화
extension String {
    
    func validationEmail() -> Bool {
        let emailRegex = "^.+@([A-Za-z0-0-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self)
        
    }
    
    func validationPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return predicate.evaluate(with: self)
    }
    
}
