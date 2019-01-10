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
    func ProductVCResponse(value: Closet)
}

class ProductSelectVC: UIViewController {

    let userDefault = UserDefaults.standard
    var delegate: ProductVCDelegate?
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var originalCloset = [Closet]()
    var closetList: [Closet]?
    var categoryIdx: Int?
    var brandIdx: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        
        searchTF.delegate = self;
        searchTF.addTarget(self, action: #selector(searchRecords( _:)), for: .editingChanged);
        
    }

    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
        
        ProductSelectService.shared.showProductList (brandIdx: _brandIdx, categoryIdx: _categoryIdx, completion: {[weak self] (closet) in
            guard let `self` = self else {return}
            self.closetList = closet
            self.tableView.reloadData()
            
            guard let closetlist = self.closetList else {return}
            for product in closetlist {
                self.originalCloset.append(product)
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
    
       self.closetList?.removeAll()
        
        if textField.text?.count != 0 {
            
            for product in originalCloset {
                if let productToSearch = textField.text {
                    let range = product.name!.lowercased().range(of: productToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {self.closetList?.append(product)}
                }
            }
            
        }
            
        else {
            for product in originalCloset {
                closetList?.append(product)
            }
        }
        
        tableView.reloadData()
        
    }
    
}



extension ProductSelectVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let closet = closetList else {return 0}
        return closet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSelectTVCell", for: indexPath) as! ProductSelectTVCell
        guard let closet = closetList else {return cell}
        
            cell.textLB.text = closet[indexPath.row].name
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let closet = closetList else {return}
        self.delegate?.ProductVCResponse(value: closet[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        }
    
}


    
    
    
    
    
    
    
