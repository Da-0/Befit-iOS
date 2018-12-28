//
//  LikeBrandTVC.swift
//  Befit
//
//  Created by 이충신 on 27/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
// 좋아요 한 브랜드 조회
// 테이블 뷰로 구성

import UIKit
import XLPagerTabStrip

class LikeBrandTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeBrandTVCell", for: indexPath) as! LikeBrandTVCell
        cell.brandName.text = "Vans"
       

        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //해당 셀의 브랜드 페이지로 이동 구현 필요.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

}

extension LikeBrandTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
}
