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
    let pickerview = UIPickerView()
    let sizeArray = ["S", "M", "L", "XL"]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeBtn.tintColor = .clear
        completeBtn.isEnabled = false
        
        sizeTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        sizeTF.delegate = self;
        initPicker()
        
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
        self.navigationController?.pushViewController(productSelectVC, animated: true)
        
    }
    
    @IBAction func completBtn(_ sender: Any) {
        print(brandName!)
        print(productName!)
        
        //서버와의 통신하여 정보 다보내기
        self.navigationController?.popViewController(animated: true)
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
    func BrandVCResponse(value: String) {
        self.brandName = value;
    }
}

//Mark: - BrandVCDelega
extension SizeInfoVC3: ProductVCDelegate {
    func ProductVCResponse(value: String) {
        self.productName = value;
    }
}


