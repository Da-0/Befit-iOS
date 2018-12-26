//
//  CategoryVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

// Category 사이드 메뉴를 생성하기 위함(테이블 뷰 필요)

import UIKit

struct cellData {
    var open: Bool!
    var title: String!
    var items: [String]?
}

struct items{
    var name: String!
    var nextViewid: String!
}

class CategoryVC: UIViewController {
    
    var tableData = [cellData]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.delegate = self;
       tableView.dataSource = self;
       tableView.separatorStyle = .none
       tableView.tableFooterView = UIView()
       
        
        tableData = [
         cellData(open: false, title: "New", items: nil),
         cellData(open: false, title: "Best", items: nil),
         cellData(open: false, title: "Women", items: ["Outer","Jacket","Coat","Vest","Hoody","Sweat Shirts","T-Shirt","Dress","Jean","Short-Pants","Skirts", "Leggings"]),
         cellData(open: false, title: "Men", items: ["Outer","Jacket","Coat","Vest","Hoody","Sweat Shirts","T-Shirt","Dress","Jean","Short-Pants"])
        ]
        
    }

}


extension CategoryVC: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableData[section].open {
            return (tableData[section].items?.count)! + 1
        }
        else{
            return 1
        }
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell") as! CategoryTVCell
            cell.titleLB.text = tableData[indexPath.section].title
            cell.titleLB.font = UIFont.systemFont(ofSize: 20)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell") as! CategoryTVCell
            cell.titleLB.text = tableData[indexPath.section].items?[indexPath.row-1]
            cell.titleLB.font = UIFont.systemFont(ofSize: 14)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return CGFloat(60)
        }else{
            return CGFloat(30)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableData[indexPath.section].open {
            tableData[indexPath.section].open = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .automatic)
            print("\(indexPath.section), \(indexPath.row)")
            
        }
            
        else{
            if indexPath.section == 2 || indexPath.section == 3 {
                tableData[indexPath.section].open = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .automatic)
                print("\(indexPath.section), \(indexPath.row)")
            }
            else{
                print("\(indexPath.section), \(indexPath.row)")
            }
        }
    }


}
