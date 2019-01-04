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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeBtn.tintColor = .clear
        completeBtn.isEnabled = false
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
      
        if brandName != nil && productName != nil {
            completeBtn.tintColor = .black
            completeBtn.isEnabled = true
        }
        
        if brandName != nil {
            brandNameLB.text = brandName
            productViewEnable(true)
        }else {
            productViewEnable(false)
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
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension SizeInfoVC3 : BrandVCDelegate {
    func BrandVCResponse(value: String) {
        self.brandName = value;
    }
}

extension SizeInfoVC3: ProductVCDelegate {
    func ProductVCResponse(value: String) {
        self.productName = value;
    }
}
