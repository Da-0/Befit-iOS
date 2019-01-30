//
//  CategoryVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Main.Storyboard
//  2) Category 사이드 메뉴를 생성하기 위한 VC (TableView)

import UIKit

struct cellData {
    var open: Bool!
    var title: String!
    var items: [Category]!
}

class CategoryVC: UIViewController {
    
    var presentedVC: UIViewController?
    var dismissJudge: Bool = false
    
    var tableData: [cellData] = [
        cellData(open: false, title: "Women", items: Category.allwomen()),
        cellData(open: false, title: "Men", items: Category.allmen())
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if dismissJudge == true {
            self.sideMenuController?.hideMenu()
        }
        self.dismissJudge = false
        
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
        let tableData = self.tableData[indexPath.section]
        
        if indexPath.row == 0 {
            cell.titleLB.text = tableData.title
            cell.titleLB.font = UIFont.systemFont(ofSize: 20)
            cell.arrowBtn.image = tableData.open ?  #imageLiteral(resourceName: "icArrowUp") : #imageLiteral(resourceName: "icArrowDown")
            cell.titleLB.textColor = tableData.open ? #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
            
        else {
            cell.titleLB.text = tableData.items?[indexPath.row-1].title
            cell.titleLB.font = UIFont.systemFont(ofSize: 14)
            cell.titleLB?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.arrowBtn.image = nil
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
        
        let sections = indexPath.section
        let rows = indexPath.row
        
        // 열려있는 경우.
        if tableData[sections].open {
            
            tableData[sections].open = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .automatic)
            
            // HaveTheRain : Go To CategoryDetailVC Code Start
            if rows >= 1 {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                
                guard let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "CategoryDetailVC") as? CategoryDetailVC else {return}
                presentedVC.genderIdx = sections
                presentedVC.categoryIdx = tableData[sections].items[rows-1].idx
                presentedVC.categoryName = tableData[sections].items[rows-1].title
                
                self.dismissJudge = true
                present(presentedVC, animated: false, completion: nil)
            }
            // HaveTheRain : Go To CategoryDetailVC Code End
            
        }
            
            
        // 닫혀있는 경우.
        else{
            tableData[sections].open = true
            let section = IndexSet.init(integer: sections)
            tableView.reloadSections(section, with: .automatic)
    
        }
    }
}




