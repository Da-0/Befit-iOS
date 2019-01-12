//
//  MainCVCell1.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class MainCVCell1: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    let imageArray = [#imageLiteral(resourceName: "banner0"), #imageLiteral(resourceName: "banner1"), #imageLiteral(resourceName: "banner2")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView1.delegate = self;
        collectionView1.dataSource = self;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "MainCVCell11", for: indexPath) as! MainCVCell11
        
        cell.bannerImage.image = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let productVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
//        
        
        
//        productVC.brandName = recommendProduct?[indexPath.row].brand_English_name
//        productVC.address = recommendProduct?[indexPath.row].link
//        //            productVC.productIdx = recommendProduct?[indexPath.row].idx
//        productVC.productInfo = recommendProduct?[indexPath.row]
//

        
    }
    
    
    
//    //FooterView 설정
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//            let cell = collectionView1.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MainCVCell12", for: indexPath as IndexPath) as! MainCVCell12
//
//            cell.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            return cell
//
//        default:
//            assert(false, "Unexpected element kind")
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    
    
}
