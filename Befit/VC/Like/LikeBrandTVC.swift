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
    var likesImage = [UIImage](repeating: #imageLiteral(resourceName: "icLikeFull"), count: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brandListInit()
        
    }
    
    func brandListInit() {
        showLikeBListService.shared.showBrandLike { (brandData) in
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
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
    
        return cell
    }
    
    
    
    //좋아요가 작동하는 부분
    @objc func clickLike(_ sender: UIButton){
        
        guard let idx = brandLikeList[sender.tag].idx else {return}
        
        if likesImage[sender.tag] == #imageLiteral(resourceName: "icLikeFull") {
            likesImage[sender.tag] = #imageLiteral(resourceName: "icLikeLine")
            
            //1)브랜드 좋아요 취소가 작동하는 부분
            LikeBService.shared.unlike(brandIdx: idx) { (res) in
                if let status = res.status {
                    switch status {
                    case 200 :
                        print("브랜드 좋아요 취소 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
            
            
        }
            
        else {
            likesImage[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            
            //2)브랜드 좋아요가 작동하는 부분
            LikeBService.shared.like(brandIdx: idx) { (res) in
                if let status = res.status {
                    switch status {
                    case 201 :
                        print("브랜드 좋아요 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
            
        }
        
        sender.setImage(likesImage[sender.tag], for: .normal)
        
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let brandVC  = UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = brandLikeList[indexPath.row]
        brandVC.brandIdx = brandLikeList[indexPath.row].idx
        self.navigationController?.pushViewController(brandVC, animated: true)
        
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
