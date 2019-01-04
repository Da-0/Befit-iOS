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

    
    let brand = ["Uniqlo", "LMC", "Nike", "라퍼지스토어", "아이오아이", "A-LAND", "BBCCAA"]
    let product = ["양털후리스", "매우매우큰자켓", "에어맥스 조던", "에어맥스 조던1111", "에어맥스 조던2222", "에어맥스 조던333",
                   "?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
            
            headerView.backgroundColor = UIColor.white;
            return headerView

        default:
            assert(false, "Unexpected element kind")
        }
        
    }

}

extension LikeProductCVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCVCell", for: indexPath) as! LikeProductCVCell
        
        cell.brandName.text = brand[indexPath.row]
        cell.productName.text = product[indexPath.row]
        cell.price.text = "550,000"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
       //let width: CGFloat = (self.collectionView.frame.width - 30) / 2
        //let height: CGFloat =  (self.collectionView.frame.height - 30) / 2
        return CGSize(width: 167, height: 235)
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






    





