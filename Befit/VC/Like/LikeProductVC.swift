//
//  LikeProductVC.swift
//  Befit
//
//  Created by 이충신 on 28/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Like.Storyboard
//  1-1) 상품 찜 목록을 보여주는 VC (CollectionView)

import UIKit
import XLPagerTabStrip

class LikeProductVC: UIViewController {

    @IBOutlet weak var tabbarHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //prevent Button image disappear in custom cell
    var productLikesImg: [UIImage]?
    var productLikeList: [Product]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        tabbarHeight.constant = (self.tabBarController?.tabBar.frame.size.height)!
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListInit()

        
    }
   
    // refreshControl이 돌아갈 때 일어나는 액션
    @objc func reloadData(_ sender: UIRefreshControl) {
        self.productListInit()
        collectionView.reloadData()
        sender.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LikeProductCRV", for: indexPath as IndexPath) as! LikeProductCRV
                cell.likeProductNumbLB.text = "찜한상품 " + "\(gino(productLikeList?.count))"
                return cell

            default:
                assert(false, "Unexpected element kind")
        }
        
    }

}

extension LikeProductVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if productLikeList == nil {
            return 0
        }
        else {
            return (productLikeList?.count)!
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVCell", for: indexPath) as! ProductCVCell
        
        if let product = productLikeList?[indexPath.row] {
            cell.productImg.imageFromUrl(product.image_url, defaultImgPath: "")
            cell.brandName.text = product.name_korean
            cell.productName.text = product.name
            cell.price.text = product.price
            
            cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.setImage(productLikesImg?[indexPath.row], for: .normal)
           
        }
        
            return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = productLikeList?[indexPath.row] else {return}
        let productVC = Storyboard.shared().product.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            productVC.productInfo = product
        self.navigationController?.present(productVC, animated: true, completion: nil)
        
    }
    
    
}

//MARK: - like function
extension LikeProductVC {
    
    //좋아요가 작동하는 부분
    @objc func clickLike(_ sender: UIButton){
        
        guard let idx = productLikeList?[sender.tag].idx else {return}
        
        //1 )상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlike(idx: idx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
        }
        
        //2) 상품 좋아요가 작동하는 부분
        else {
            like(idx: idx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        }
        
    }
}


extension LikeProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 167, height: 239)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0 , left: 15, bottom: 15, right: 15)
    }
    
}


extension LikeProductVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "상품")
    }
}

//Mark: - Network Service
extension LikeProductVC{

    func productListInit() {
        showLikePListService.shared.showProductLike { (value) in
            guard let status = value.status else {return}
            switch status {
            case 200:
                if value.data == nil { self.productLikeList = nil}
                else{
                    self.productLikeList = value.data
                    self.productLikesImg = []
                    for product in value.data! {
                        let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                        self.productLikesImg?.append(likeImg)
                    }
                    self.collectionView.reloadData()
                }
            default:
                break
            }
        }
    }
    
    func like(idx: Int){
        LikePService.shared.like(productIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                case 201 :
                    print("상품 좋아요 성공!")
                case 400...600 :
                    self.simpleAlert(title: "ERROR", message: res.message!)
                default: return
                }
            }
        }
    }
        
    func unlike(idx: Int){
        LikePService.shared.unlike(productIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                case 200 :
                    print("상품 좋아요 취소 성공!")
                case 400...600 :
                    self.simpleAlert(title: "ERROR", message: res.message!)
                default: return
                }
            }
        }
    }
    
}




    





