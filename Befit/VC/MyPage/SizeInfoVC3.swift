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
    
    @IBOutlet weak var addSizeBtn: UIBarButtonItem!
    
    //Cell 0
    @IBOutlet weak var brandSelectView: UIControl!
    @IBOutlet weak var brandNameLB: UILabel!
    
    //Cell 1
    @IBOutlet weak var productSelectView: UIControl!
    @IBOutlet weak var productTitleLB: UILabel!
    @IBOutlet weak var productNameLB: UILabel!
    @IBOutlet weak var arrowBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        productTitleLB.textColor = #colorLiteral(red: 0.6852758527, green: 0.6852921844, blue: 0.6852833629, alpha: 1)
        arrowBtn.tintColor = #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func brandSelectAction(_ sender: Any) {
        let sizeInfoVC3 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
        self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
    }
    
    
    @IBAction func productSelectAction(_ sender: Any) {
        let sizeInfoVC3 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
        self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}



