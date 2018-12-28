//
//  MyPageVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = ["나의 패션 취향", "나의 사이즈 정보", "통합회원정보관리", "고객센터" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
   
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 20))
    }
    

    @IBAction func settingBtn(_ sender: Any) {
        
        let myPage = UIStoryboard.init(name: "MyPage", bundle: nil)
        let settingVC = myPage.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
        self.navigationController?.pushViewController(settingVC!, animated: true)
    }
    
    

}


extension MyPageVC : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTVCell") as! MyPageTVCell
    
        cell.titleLB.text = tableData[indexPath.row]
    
        return cell
    }
    
}
