import UIKit

class UserInfoVC3: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var duplicationLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordNoticeLB: UILabel!
    @IBOutlet weak var passwordCkTF: UITextField!
    @IBOutlet weak var correctLB: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
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
        setKeyboardSetting()
        setupTap()
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
            passwordNoticeLB.textColor =   #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 0.5)
        }
        else {
            passwordCkTF.isEnabled = false
            passwordNoticeLB.textColor =  #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
            
        }
        
    }
    
    // 비밀번호 확인
    @IBAction func pwCkAction(_ sender: Any) {
        
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
    
    @objc func completeWrite() {
        
        guard nameTF.text?.isEmpty != true else {return}
        guard yearTF.text?.isEmpty != true else {return}
        guard monthTF.text?.isEmpty != true else {return}
        guard dayTF.text?.isEmpty != true else {return}
        guard emailTF.text?.isEmpty != true else {return}
        guard passwordTF.text?.isEmpty != true else {return}
        guard passwordCkTF.text?.isEmpty != true else {return}
    }
    
    
    
    @IBAction func nextAction(_ sender: Any) {
    }
    
    
}

//MARK: - picker
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
    
    
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(viewTap)
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    
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
