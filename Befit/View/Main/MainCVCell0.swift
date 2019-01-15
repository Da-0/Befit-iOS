//
//  Main0CVCell.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class MainCVCell0: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView0: UICollectionView!
    
    var brandInfo: [Brand] = []
    var productInfo: [Product]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView0.delegate = self;
        collectionView0.dataSource = self;
        collectionView0.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView0.dequeueReusableCell(withReuseIdentifier: "MainCVCell00", for: indexPath) as! MainCVCell00
        
        guard let product = brandInfo[indexPath.row].products else {return cell}
        
        cell.brandMainImg.imageFromUrl(brandInfo[indexPath.row].mainfeed_url, defaultImgPath: "")
        cell.brandName.text = brandInfo[indexPath.row].name_english
        
        cell.productImg1.imageFromUrl(product[0].image_url, defaultImgPath: "")
        cell.productImg2.imageFromUrl(product[1].image_url, defaultImgPath: "")
        cell.productImg3.imageFromUrl(product[2].image_url, defaultImgPath: "")
        
        cell.productLB1.text = product[0].price
        cell.productLB2.text = product[1].price
        cell.productLB3.text = product[2].price
        
        return cell
    
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 375, height: 526)
    }
}
