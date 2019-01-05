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
         cellData(open: false, title: "Men", items: ["Outer","Jacket","Coat","Vest","Hoody","Sweat Shirts","T-Shirt","Jean","Short-Pants"])
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell") as! CategoryTVCell
        
        if indexPath.section == 2 || indexPath.section == 3 {
            
            if indexPath.row == 0 {
                
                cell.titleLB.text = tableData[ indexPath.section].title
                cell.titleLB.font = UIFont.systemFont(ofSize: 20)
                cell.arrowBtn.image = tableData[indexPath.section].open ?  #imageLiteral(resourceName: "icArrowUp") : #imageLiteral(resourceName: "icArrowDown")
                cell.titleLB.textColor = tableData[indexPath.section].open ? #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
     
            }
            
            else {
                cell.titleLB.text = tableData[indexPath.section].items?[indexPath.row-1]
                cell.titleLB.font = UIFont.systemFont(ofSize: 14)
                cell.titleLB?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.arrowBtn.image = nil
            }
        
        }else{
            cell.titleLB.text = tableData[ indexPath.section].title
            cell.titleLB.font = UIFont.systemFont(ofSize: 20)
            
        }
        
        return cell

    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(60)
        }else{
            return CGFloat(30)
        }
    }
    
    
    //Mark: - DidselectRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 열려있는 경우.
        if tableData[indexPath.section].open {
            
            tableData[indexPath.section].open = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .automatic)
            
            print("\(indexPath.section), \(indexPath.row)")
            
            print("아우터!!")
//            let navigationCon = sideMenuController?.contentViewController as! UINavigationController
//            
//            let categoryDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryDetailVC")as! CategoryDetailVC
//            navigationCon.pushViewController(categoryDetailVC, animated: true)
            
        }
        
        // 닫혀있는 경우.
        else{
            
            if indexPath.section == 2 || indexPath.section == 3 {
                
                tableData[indexPath.section].open = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .automatic)
                
                print("\(indexPath.section), \(indexPath.row)")
                print("Outer!!!"
                )
                
            }
             
            //New, Best뷰로 이동
            else{
                print("\(indexPath.section), \(indexPath.row)")
            }
        }
    }


}
