//
//  LikeProductCVC.swift
//  Befit
//
//  Created by 이충신 on 28/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
// 좋아요 한 상품 조회
// 콜렉션 뷰로 구성

import UIKit
import XLPagerTabStrip

class LikeProductCVC: UIViewController {

    @IBOutlet weak var tabbarHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var productLikeList = [Product]()
    var likesImage = [UIImage](repeating: #imageLiteral(resourceName: "icLikeFull"), count: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        tabbarHeight.constant = (self.tabBarController?.tabBar.frame.size.height)!
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListInit()
    }
    
    
    func productListInit() {
        LikeProductService.shared.showProductLike { (productData) in
            self.productLikeList = productData
            self.collectionView.reloadData()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LikeProductCRV", for: indexPath as IndexPath) as! LikeProductCRV
                cell.likeProductNumbLB.text = "찜한상품 " + "\(productLikeList.count)"
                return cell

            default:
                assert(false, "Unexpected element kind")
        }
        
    }

}

extension LikeProductCVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return productLikeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = productLikeList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCVCell", for: indexPath) as! LikeProductCVCell
        
        cell.productImg.imageFromUrl(product.image_url, defaultImgPath: "")
        cell.brandName.text = product.name_korean
        cell.productName.text = product.name
        cell.price.text = product.price
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
    
        return cell
    }

    
    //좋아요가 작동하는 부분
    @objc func clickLike(_ sender: UIButton){
        
        guard let idx = productLikeList[sender.tag].idx else {return}
        
        if likesImage[sender.tag] == #imageLiteral(resourceName: "icLikeFull") {
            likesImage[sender.tag] = #imageLiteral(resourceName: "icLikeFull2")
            
            //상품 좋아요 취소가 작동하는 부분
            UnLikePService.shared.unlike(productIdx: idx) { (res) in
                if let status = res.status {
                    switch status {
                        case 200 :
                            print("상품좋아요 취소 성공!")
                        case 400...600 :
                            self.simpleAlert(title: "ERROR", message: res.message!)
                        default: break
                    }
                }
            }
            
            
        }
        else {
            likesImage[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            //상품 좋아요가 작동하는 부분
            LikePService.shared.like(productIdx: idx) { (res) in
                if let status = res.status {
                    switch status {
                    case 201 :
                           print("상품좋아요 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
            
        }
        
        sender.setImage(likesImage[sender.tag], for: .normal)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        productVC.brandName = productLikeList[indexPath.row].name_English
        productVC.address = productLikeList[indexPath.row].link
//        productVC.productIdx = productLikeList[indexPath.row].idx
        self.navigationController?.present(productVC, animated: true, completion: nil)
        
    }
    
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


extension LikeProductCVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "상품")
    }
}






    





