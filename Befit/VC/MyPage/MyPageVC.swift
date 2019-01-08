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
    var gender: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = ["나의 패션 취향", "나의 사이즈 정보", "통합회원정보관리", "고객센터"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
   
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 20))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
    }
    
    @IBAction func settingBtn(_ sender: Any) {
        let settingVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.present(settingVC, animated: true, completion: nil)
    }
    
    func network(){
        UserInfoService.shared.showUserInfo { (res) in
            
            print("\n<***현재 회원 정보***>")
            print(res)
            
            self.userName.text = res.name
            self.userId.text = res.email
            self.gender = res.gender
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
            case 0:
                print("나의 패션 취향 뷰로 이동")
                let changeBrandVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "ChangeBrandVC")as! ChangeBrandVC
                    changeBrandVC.gender = self.gender
                self.navigationController?.pushViewController(changeBrandVC, animated: true)
            
            case 1:
                print("나의 사이즈정보 뷰로 이동")
                let sizeInfoVC1 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC1")as! SizeInfoVC1
                sizeInfoVC1.gender = self.gender
                self.navigationController?.pushViewController(sizeInfoVC1, animated: true)
            
            case 2:
                print("통합회원정보 관리 뷰로 이동")
                
                let userInfoAdminVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "UserInfoAdminVC")as! UserInfoAdminVC
                self.navigationController?.present(userInfoAdminVC, animated: true, completion: nil)
            
            case 3:
                print("고객센터 뷰로 이동")
            default:
                break
            }
        
     }
    
}

