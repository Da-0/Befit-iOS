//
//  LikeBrandVC.swift
//  Befit
//
//  Created by 이충신 on 27/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Like.Storyboard
//  1-2) 브랜드 찜 목록을 보여주는 VC (TableView)

import UIKit
import XLPagerTabStrip

class LikeBrandVC: UIViewController{
    
    @IBOutlet weak var tabbarHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    //prevent Button image disappear in custom cell
    var brandLikesImg: [UIImage]?
    var brandLikeList: [Brand]?
    @IBOutlet weak var likeBrandNumb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //tabbarHeight.constant = (self.tabBarController?.tabBar.frame.size.height)!
        tabbarHeight.constant = 44
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brandListInit()
        
    }
    
    // refreshControl이 돌아갈 때 일어나는 액션
    @objc func reloadData(_ sender: UIRefreshControl) {
        self.brandListInit()
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    
}

extension LikeBrandVC: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if brandLikeList == nil {
            self.likeBrandNumb.text = "찜한브랜드 0"
            return 0
        }
        else {
            self.likeBrandNumb.text = "찜한브랜드 " + "\(gino(brandLikeList?.count))"
            return (brandLikeList?.count)!
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeBrandTVCell", for: indexPath) as! LikeBrandTVCell
        
        if let brands = brandLikeList?[indexPath.row] {
            
            cell.brandImg.imageFromUrl(brands.logo_url!, defaultImgPath: "")
            cell.brandName.text = brands.name_english
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.setImage(brandLikesImg?[indexPath.row], for: .normal)
            cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let brandVC  = Storyboard.shared().brand.instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = brandLikeList?[indexPath.row]
        self.navigationController?.pushViewController(brandVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    
}


//MARK: - like function
extension LikeBrandVC {
    
    @objc func clickLike(_ sender: UIButton){
        
        guard let idx = brandLikeList?[sender.tag].idx else {return}
        
        //1) 브랜드 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlike(idx: idx)
            brandLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
        }
            
        //2) 브랜드 좋아요가 작동하는 부분
        else {
            like(idx: idx)
            brandLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        }
        
    }
    
}

extension LikeBrandVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
}

//Mark: - Network Service
extension LikeBrandVC{
    
    func brandListInit() {
        showLikeBListService.shared.showBrandLike { (value) in
            
            guard let status = value.status else {return}
            switch status {
            case 200:
                if value.data == nil { self.brandLikeList = nil}
                else{
                    self.brandLikeList = value.data
                    self.brandLikesImg = []
                    for brand in value.data! {
                        let likeImg = brand.likeFlag == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                        self.brandLikesImg?.append(likeImg)
                    }
                    self.tableView.reloadData()
                }
            default:
                break
            }
            
        }
    }
    
    func like(idx: Int){
        LikeBService.shared.like(brandIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                case 201 :
                    print("브랜드 좋아요 성공!")
                case 400...600 :
                    self.simpleAlert(title: "ERROR", message: res.message!)
                default: return
                }
            }
        }
    }
    
    func unlike(idx: Int){
        LikeBService.shared.unlike(brandIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                case 200 :
                    print("브랜드 좋아요 취소 성공!")
                case 400...600 :
                    self.simpleAlert(title: "ERROR", message: res.message!)
                default: return
                }
            }
        }
    }
    
}
