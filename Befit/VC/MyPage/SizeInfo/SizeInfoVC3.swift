//
//  SizeInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

//브랜드 검색과 상품검색이 일어나는 TableView
//검색을 모두 마친뒤에는 isHidden = false 로 변경

import UIKit

class SizeInfoVC3: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    //Right BarButton Item
    @IBOutlet weak var completeBtn: UIBarButtonItem!
    
    //Cell 0
    @IBOutlet weak var brandSelectView: UIControl!
    @IBOutlet weak var brandNameLB: UILabel!
    var brandName: String?
 
    //Cell 1
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
    
    
    var brandIdx: Int?
    var categoryIdx: Int?
    var productIdx: Int?
    var productSize: String?
    var idx: Int = 0
    
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
        
        if brandName != nil {
            
            brandNameLB.text = brandName
            productViewEnable(true)
            
            if productName != nil {
                ContentView.isHidden = false
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        productViewEnable(false)
        productName = nil
       
    }
    
    func productViewEnable(_ enable: Bool){
        
        productSelectView.isUserInteractionEnabled = enable ? true : false
        productTitleLB.textColor = enable ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6235294118, alpha: 1)
        productNameLB.isHidden = enable ? false : true
        arrowBtn.image = enable ? #imageLiteral(resourceName: "rightArrow") : #imageLiteral(resourceName: "rightArrow2")
        productNameLB.text = productName != nil ? productName : nil
    
    }

}

//Mark: - Button Action 관련

extension SizeInfoVC3 {
    
    @IBAction func brandSelectAction(_ sender: Any) {
        
        let brandSelectVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "BrandSelectVC")as! BrandSelectVC
        brandSelectVC.delegate = self;
        self.navigationController?.pushViewController(brandSelectVC, animated: true)
    }
    
    
    @IBAction func productSelectAction(_ sender: Any) {
        
        let productSelectVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "ProductSelectVC")as! ProductSelectVC
        
        productSelectVC.delegate = self;
        productSelectVC.brandIdx = self.brandIdx;
        productSelectVC.categoryIdx = self.categoryIdx;
        
        self.navigationController?.pushViewController(productSelectVC, animated: true)
        
    }
    
    @IBAction func completBtn(_ sender: Any) {
        
        AddClosetService.shared.addCloset(idx: productIdx!, size: productSize!) { (res) in
            if let status = res.status {
                print(res)
                switch status {
                    case 200, 201:
                          self.navigationController?.popViewController(animated: true)
                    case 400...600 :
                        self.simpleAlert(title: "Error", message: res.message!)
                    default: break
                }
            }
        }
    
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
     
        let key = realValueArray[row].keys
        let value = realValueArray[row].values
        
        self.stackView.isHidden = false
        
        if value.count == 3 {
            fourthStack.isHidden = true
            fifthStack.isHidden = true
        }
        if value.count == 4 {
            fifthStack.isHidden = true
        }
        
        
        for k in key {
            switch k {
                case "totalLength":
                    self.LB0Array[self.idx].text = "총장"
                    break
                case "chestSection":
                    self.LB0Array[self.idx].text = "가슴 단면"
                    break
                case "shoulderWidth":
                    self.LB0Array[self.idx].text = "어깨 너비"
                    break
                case "sleeveLength":
                    self.LB0Array[self.idx].text = "소매 길이"
                    break
                case "waistSection":
                    self.LB0Array[self.idx].text = "허리 단면"
                    break
                case "thighSection":
                    self.LB0Array[self.idx].text = "허벅지 단면"
                    break
                case "crotch":
                    self.LB0Array[self.idx].text = "밑위"
                    break
                case "dobladillosSection":
                    self.LB0Array[self.idx].text = "밑단 단면"
                    break
            default:
                break
            }
            idx += 1
        }
        
        idx = 0
        
        for v in value {
           self.LB1Array[self.idx].text =  v as? String
            idx += 1
        }
        
        idx = 0
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
        self.brandName = value.name_english
        self.brandIdx = value.idx
    
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
        print("\n key값 = \(measureData.keys)")
        print(" value값 = \(measureData.values)")
        
   
        for size in measureData.keys {
            sizeArray.append(size)
        }
        
        for values in measureData.values {
            realValueArray.append(values as! [String : Any])
        }

    }
}


