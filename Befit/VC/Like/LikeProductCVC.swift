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

    @IBOutlet weak var collectionView: UICollectionView!
    var productLikeList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListInit()
    }
    
    
    func productListInit() {
        LikeProductService.shared.showProductLike { (productData) in
           // self.likeBrandNumb.text = "찜한브랜드 " + "\(self.brandLikeList.count)"
            self.productLikeList = productData
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
                headerView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                return headerView

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
        
        cell.brandName.text = product.brand_Korean_name
        cell.productName.text = product.name
        cell.price.text = product.price
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
       //let width: CGFloat = (self.collectionView.frame.width - 30) / 2
        //let height: CGFloat =  (self.collectionView.frame.height - 30) / 2
        return CGSize(width: 167, height: 239)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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






    





