//
//  SizeInfoVC1.swift
//  Befit
//
//  Created by 이충신 on 01/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class SizeInfoVC1: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categoryList: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //*****Test용(성별을 gender에 받아오는것에 따라 달리 출력)
        UserDefaults.standard.set("남", forKey: "gender")
        initGender()
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
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func initGender(){
        
        if UserDefaults.standard.string(forKey: "gender") == "남" {
            categoryList = Category.allmen()
        }else {
            categoryList = Category.allwomen()
        }
    }

}

extension SizeInfoVC1: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeInfo1TVCell", for: indexPath) as! SizeInfo1TVCell
        
            cell.categoryImg.image = categoryList[indexPath.row].image
            cell.categoryName.text = categoryList[indexPath.row].title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sizeInfoVC2 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC2")as! SizeInfoVC2
        
        sizeInfoVC2.categoryName = categoryList[indexPath.row].title
        
        self.navigationController?.pushViewController(sizeInfoVC2, animated: true)
  
    }
    
    
    

    
}
