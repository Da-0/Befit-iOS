//
//  SizeInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  3-3) 브랜드 검색과 상품검색이 일어나는 VC


import UIKit

class SizeInfoVC3: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    //Right BarButton Item
    @IBOutlet weak var completeBtn: UIBarButtonItem!
    
    //Brand Select Button
    @IBOutlet weak var brandSelectView: UIControl!
    @IBOutlet weak var brandNameLB: UILabel!
 
    //Product Select Button
    @IBOutlet weak var productSelectView: UIControl!
    @IBOutlet weak var productTitleLB: UILabel!
    @IBOutlet weak var productNameLB: UILabel!
    @IBOutlet weak var arrowBtn: UIImageView!
    var productName: String?
    
    //ContentView
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var CproductImg: UIImageView!
    @IBOutlet weak var CproductName: UILabel!
    @IBOutlet weak var sizeTF: UITextField!
   
    var productInformation: Product?
    let pickerview = UIPickerView()
    var sizeArray = [String]()
    var realValueArray = [[String: Any]]()
    @IBOutlet weak var stackView: UIStackView!
    
    var brandInfo: Brand?
    var categoryIdx: Int?
    var productIdx: Int?
    var productSize: String?
    var enrollNewCloset = false
    
    @IBOutlet weak var fourthStack: UIStackView!
    @IBOutlet weak var fifthStack: UIStackView!
    
    @IBOutlet weak var LB00: UILabel!
    @IBOutlet weak var LB01: UILabel!
    @IBOutlet weak var LB02: UILabel!
    @IBOutlet weak var LB03: UILabel!
    @IBOutlet weak var LB04: UILabel!
    var LB0Array = [UILabel]()
    
    @IBOutlet weak var LB10: UILabel!
    @IBOutlet weak var LB11: UILabel!
    @IBOutlet weak var LB12: UILabel!
    @IBOutlet weak var LB13: UILabel!
    @IBOutlet weak var LB14: UILabel!
    var LB1Array = [UILabel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeBtn.tintColor = .clear
        completeBtn.isEnabled = false
        
        stackView.isHidden = true
        
        sizeTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        sizeTF.delegate = self;
        initPicker()
        setLB()
        
    }
    
    func setLB(){
        
        LB0Array.append(LB00)
        LB0Array.append(LB01)
        LB0Array.append(LB02)
        LB0Array.append(LB03)
        LB0Array.append(LB04)
        
        LB1Array.append(LB10)
        LB1Array.append(LB11)
        LB1Array.append(LB12)
        LB1Array.append(LB13)
        LB1Array.append(LB14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        if brandInfo != nil {
            
            brandNameLB.text = brandInfo?.name_english
            productViewEnable(true)
            
            if productName != nil { ContentView.isHidden = false}
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
       
    }
    
    func productViewEnable(_ enable: Bool){
        
        productSelectView.isUserInteractionEnabled = enable ? true : false
        productTitleLB.textColor = enable ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6235294118, alpha: 1)
        productNameLB.isHidden = enable ? false : true
        arrowBtn.image = enable ? #imageLiteral(resourceName: "rightArrow") : #imageLiteral(resourceName: "rightArrow2")
        productNameLB.text = productName != nil ? productName : nil
    
    }

}

//Mark: - Button Action
extension SizeInfoVC3 {
    
    @IBAction func brandSelectAction(_ sender: Any) {
        
        //브랜드 선택시에는 ContentView가 false
        productViewEnable(false)
        productName = nil
        ContentView.isHidden = true
        
        let brandSelectVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "BrandSelectVC")as! BrandSelectVC
        brandSelectVC.delegate = self;

        if enrollNewCloset == true{
            brandSelectVC.enrollNewCloset = true
            self.present(brandSelectVC, animated: true, completion: nil)
        }
        else{
            self.navigationController?.pushViewController(brandSelectVC, animated: true)
        }
    }
    
    
    @IBAction func productSelectAction(_ sender: Any) {
        
        let productSelectVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "ProductSelectVC")as! ProductSelectVC
        
        productSelectVC.delegate = self;
        productSelectVC.brandIdx = brandInfo?.idx
        productSelectVC.categoryIdx = self.categoryIdx;
  
        if enrollNewCloset == true {
            productSelectVC.enrollNewCloset = true
            self.present(productSelectVC, animated: true, completion: nil)
        }
        else{
            self.navigationController?.pushViewController(productSelectVC, animated: true)
        }
        
    }
    
    @IBAction func completBtn(_ sender: Any) {
        
        AddClosetService.shared.addCloset(idx: productIdx!, size: productSize!) { (res) in
            if let status = res.status {
                switch status {
                    case 200, 201:
                        if self.enrollNewCloset == true {
                            self.dismiss(animated: true, completion: nil)
                        }else{
                          self.navigationController?.popViewController(animated: true)
                        }
                    case 400...600 :
                        self.simpleAlert(title: "Error", message: res.message!)
                    default: break
                }
            }
        }
    
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}



//Mark: - UITExtFieldDelegate
extension SizeInfoVC3: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        completeBtn.tintColor = .black
        completeBtn.isEnabled = true
    }
    
}


//Mark: - UIPicker
extension SizeInfoVC3 : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func initPicker() {
        
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        
        bar.setItems([flexible,doneButton], animated: true)
        
        sizeTF.inputAccessoryView = bar
        sizeTF.inputView = pickerview
    }
    
    @objc func selectedPicker(){
        
        let row = pickerview.selectedRow(inComponent: 0)
        sizeTF.text = sizeArray[row]
        productSize = sizeArray[row]
     
        
        let dicData = realValueArray[row].sorted(by: { (first, second) -> Bool in
            
            switch (first.key, second.key) {
            case ("totalLength", _ ) :
                return true
            case (_ ,"totalLength") :
                return false
            default: break
            }
            return first.key > second.key
        })
        
        
        self.stackView.isHidden = false
        
        if dicData.count == 3 {
            fourthStack.isHidden = true
            fifthStack.isHidden = true
        }
        if dicData.count == 4 {
            fourthStack.isHidden = false
            fifthStack.isHidden = true
        }
        

        
        for (idx, data) in dicData.enumerated() {
            
            switch data.key {
                case "totalLength":
                    self.LB0Array[idx].text = BodyPart.total.rawValue
                    break
                case "chestSection":
                    self.LB0Array[idx].text = BodyPart.chest.rawValue
                    break
                case "shoulderWidth":
                    self.LB0Array[idx].text = BodyPart.shoulder.rawValue
                    break
                case "sleeveLength":
                    self.LB0Array[idx].text = BodyPart.sleeve.rawValue
                    break
                case "waistSection":
                    self.LB0Array[idx].text = BodyPart.waist.rawValue
                    break
                case "thighSection":
                    self.LB0Array[idx].text = BodyPart.thigh.rawValue
                    break
                case "crotch":
                    self.LB0Array[idx].text = BodyPart.crotch.rawValue
                    break
                case "dobladillosSection":
                    self.LB0Array[idx].text = BodyPart.dobla.rawValue
                    break
            default:
                break
            }
            
            self.LB1Array[idx].text = data.value as? String
            
        
        }
      
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeArray[row]
    }
    
}


//Mark: - BrandVCDelegate
extension SizeInfoVC3 : BrandVCDelegate {
    func BrandVCResponse(value: Brand) {
        self.brandInfo = value
    }
}



//Mark: - BrandVCDelega
extension SizeInfoVC3: ProductVCDelegate {
    
    func ProductVCResponse(value: Product) {
        
        sizeArray.removeAll()
        realValueArray.removeAll()
        
        self.productInformation = value
        
        self.CproductImg.imageFromUrl(value.image_url!, defaultImgPath: "")
        self.CproductName.text = value.name
        self.productName = value.name
        self.productIdx = value.idx
        
        guard let measureData = value.measure1?.toJSON() else {return}
        
        let realRoot = measureData.sorted { (first, second) -> Bool in
            if let firstVal = sortedDic[first.key], let secondVal = sortedDic[second.key] {
                if firstVal < secondVal { return true }
                else { return false }
            }
            return first.key < second.key
        }
        
        
        for data in realRoot {
            sizeArray.append(data.key)
            realValueArray.append(data.value as! [String:Any])
        }
 
        print("\nkey값 = \(sizeArray)")
        print("value값 = \(realValueArray)")
   

    }
}


