//
//  BrandSelectVC.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

protocol BrandVCDelegate
{
    func BrandVCResponse(value: String)
}

class BrandSelectVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    var delegate: BrandVCDelegate?

    @IBOutlet weak var tableView: UITableView!
    var brand: [Brand]? = []
    var selectedButton: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()

    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        switch sender.tag {
            case 0: selectedButton = "A"; case 1: selectedButton = "B"
            case 2: selectedButton = "C"; case 3: selectedButton = "D"
            case 4: selectedButton = "E"; case 5: selectedButton = "F"
            case 6: selectedButton = "G"; case 7: selectedButton = "H"
            case 8: selectedButton = "I"; case 9: selectedButton = "J"
            case 10: selectedButton = "K"; case 11: selectedButton = "L"
            case 12: selectedButton = "M"; case 13: selectedButton = "N"
            case 14: selectedButton = "O"; case 15: selectedButton = "P"
            case 16: selectedButton = "Q"; case 17: selectedButton = "R"
            case 18: selectedButton = "S"; case 19: selectedButton = "T"
            case 20: selectedButton = "U"; case 21: selectedButton = "V"
            case 22: selectedButton = "W"; case 23: selectedButton = "X"
            case 24: selectedButton = "Y"; case 25: selectedButton = "Z"
            case 26: selectedButton = ""
            default: break
        }
        
        userDefault.set(selectedButton!, forKey: "brand_initial")
        
        BrandSelectService.shared.showBrandList { (brandList) in
            self.brand = brandList
            self.tableView.reloadData()
        }
        
    }
    
    
    
}


extension BrandSelectVC : UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if brand == nil {
            return 0
        }else {
            return brand!.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandSelectTVCell", for: indexPath) as! BrandSelectTVCell
        guard let _brand = brand else {return cell}
        
        cell.brandName.text = _brand[indexPath.row].name_english
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let _brand = brand else {return}
        self.delegate?.BrandVCResponse(value: _brand[indexPath.row].name_english!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
