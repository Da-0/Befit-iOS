//
//  ProductSelectVC.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  3-5) 브랜드 검색과 상품검색이 일어나는 뷰(TableView)

import UIKit

protocol ProductVCDelegate
{
    func ProductVCResponse(value: Product)
}

class ProductSelectVC: UIViewController {

    var delegate: ProductVCDelegate?
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var originalProduct = [Product]()
    var productList: [Product]?
    var categoryIdx: Int?
    var brandIdx: Int?
    var enrollNewCloset = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        
        searchTF.delegate = self;
        searchTF.addTarget(self, action: #selector(searchRecords( _:)), for: .editingChanged);
        
    }

    @IBAction func backBtn(_ sender: Any) {
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        network()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func network(){
        
        guard let _brandIdx = brandIdx else { return}
        guard let _categoryIdx = categoryIdx else {return}
        
        ProductSelectService.shared.showProductList (brandIdx: _brandIdx, categoryIdx: _categoryIdx, completion: {[weak self] (product) in
            guard let `self` = self else {return}
            self.productList = product
            self.tableView.reloadData()
            guard let plist = self.productList else {return}
            for product in plist {
                self.originalProduct.append(product)
            }
        })
    }
    
}


extension ProductSelectVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTF.resignFirstResponder()
        return true
    }
    
    @objc func searchRecords(_ textField: UITextField){
    
       self.productList?.removeAll()
        
        if textField.text?.count != 0 {
            
            for product in originalProduct {
                if let productToSearch = textField.text {
                    let range = product.name!.lowercased().range(of: productToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {self.productList?.append(product)}
                }
            }
            
        }
            
        else {
            for product in originalProduct {
                productList?.append(product)
            }
        }
        
        tableView.reloadData()
        
    }
    
}



extension ProductSelectVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let product = productList else {return 0}
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSelectTVCell", for: indexPath) as! ProductSelectTVCell
        guard let product = productList else {return cell}
        
            cell.textLB.text = product[indexPath.row].name
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = productList else {return}
        self.delegate?.ProductVCResponse(value: product[indexPath.row])
        
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


    
    
    
    
    
    
    
