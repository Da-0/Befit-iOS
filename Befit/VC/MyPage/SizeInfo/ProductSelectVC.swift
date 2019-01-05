//
//  ProductSelectVC.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

protocol ProductVCDelegate
{
    func ProductVCResponse(value: String)
}


class ProductSelectVC: UIViewController {

    let userDefault = UserDefaults.standard
    var delegate: ProductVCDelegate?
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var products:[String] = ["나이키 슈즈", "조던 스포츠웨어 티" ,"아이스 아메리카노" , "카페모카", "바닐라 라떼", "고구마 라떼", "콜드브류", "꼬미", "야옹아", "그만좀 울자"]
    var originalproducts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        
        searchTF.delegate = self;
        searchTF.addTarget(self, action: #selector(searchRecords( _:)), for: .editingChanged);
        
        for product in products {
            originalproducts.append(product)
        }

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
    
}

extension ProductSelectVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTF.resignFirstResponder()
        return true
    }
    
    @objc func searchRecords(_ textField: UITextField){
        
        self.products.removeAll()
        
        if textField.text?.count != 0 {
            for product in originalproducts {
                if let productToSearch = textField.text {
                    let range = product.lowercased().range(of: productToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {self.products.append(product)}
                }
            }
        }
        else {
            for product in originalproducts {
                products.append(product)
            }
        }
        
        tableView.reloadData()
    }
    
}



extension ProductSelectVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSelectTVCell", for: indexPath) as! ProductSelectTVCell
        
          cell.textLB.text =  products[indexPath.row]
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.ProductVCResponse(value: products[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        }
    
}


    
    
    
    
    
    
    
