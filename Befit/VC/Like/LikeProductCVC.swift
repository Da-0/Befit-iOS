//
//  LikeProductCVC.swift
//  Befit
//
//  Created by 이충신 on 28/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LikeProductCVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
    
    }


}

extension LikeProductCVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCVCell", for: indexPath) as! LikeProductCVCell
        
        cell.brandName.text = "hello"
        cell.productName.text = "world!!"
        cell.price.text = "100,000"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
        let width: CGFloat = (view.frame.width - 30) / 2
        let height: CGFloat =  (view.frame.width - 30) / 2 + 58
        
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}


extension LikeProductCVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "상품")
    }
}
