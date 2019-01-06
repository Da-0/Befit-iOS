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
    
    @IBOutlet weak var likeBrandNumb: UILabel!
    var brandLikeList = [Brand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brandListInit()
        
    }
    
    func brandListInit() {
        LikeBrandService.shared.showBrandLike { (brandData) in
            self.likeBrandNumb.text = "찜한브랜드 " + "\(self.brandLikeList.count)"
            self.brandLikeList = brandData
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandLikeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let brand = brandLikeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeBrandTVCell", for: indexPath) as! LikeBrandTVCell
        cell.brandImg.imageFromUrl(brand.logo_url!, defaultImgPath: "")
        cell.brandName.text = brand.name_english
        //cell.likeBtn
    
        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //해당 셀의 브랜드 페이지로 이동 구현 필요.
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.white
//        return headerView
//    }
    

}

extension LikeBrandTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
}
