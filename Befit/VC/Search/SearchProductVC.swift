//
//  SearchProductVC.swift
//  Befit
//
//  Created by 이충신 on 29/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchProductVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let brand = ["Uniqlo", "LMC", "Nike", "라퍼지스토어", "아이오아이", "A-LAND", "BBCCAA"]
    let product = ["양털후리스", "매우매우큰자켓", "에어맥스 조던", "에어맥스 조던1111", "에어맥스 조던2222", "에어맥스 조던333",
                "?"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    

}

extension SearchProductVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
            case UICollectionView.elementKindSectionHeader:
                
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCRV", for: indexPath as IndexPath) as! SearchCRV
                
                cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                cell.isUserInteractionEnabled = true
                cell.popularBtn.addTarget(self, action: #selector(popularReload), for: .touchUpInside)
                cell.newBtn.addTarget(self, action: #selector(newReload), for: .touchUpInside)
                return cell
            
            default:
                assert(false, "Unexpected element kind")
        }
        
    }
    
    
    @objc func popularReload(){
        print("인기순으로 상품이 정렬 되었습니다!!")
    }
    @objc func newReload(){
        print("신상순으로 상품이 정렬 되었습니다!!")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brand.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchProductCVCell", for: indexPath) as! SearchProductCVCell
        
        cell.brandName.text = brand[indexPath.row]
        cell.productName.text = product[indexPath.row]
        cell.price.text = "550,000"
        
        return cell
    }

    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
//            
//            headerView.backgroundColor = UIColor.white;
//            return headerView
//            
//        default:
//            assert(false, "Unexpected element kind")
//        }
//        
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
       // let width: CGFloat = (self.collectionView.frame.width ) / 2 - 20
       // let height: CGFloat =  (self.collectionView.frame.height ) / 2 - 20
        
        return CGSize(width: 167, height: 235)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    
}


extension SearchProductVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "상품")
    }
}


    

    

