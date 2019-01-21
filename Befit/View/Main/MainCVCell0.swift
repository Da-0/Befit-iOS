//
//  Main0CVCell.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

protocol customCellDelegate: class {
        func mainBrandPressed(cell: MainCVCell0, idx: Int)
        func brandProductsPressed(cell: MainCVCell0, idx: Int)
}

class MainCVCell0: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView0: UICollectionView!

    var delegate: customCellDelegate?
    
    var brandInfo: [Brand] = []
    var productInfo: [Product]?
    
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var pagerLeftCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView0.delegate = self;
        collectionView0.dataSource = self;
        collectionView0.reloadData()
        collectionView0.flashScrollIndicators()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return brandInfo.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView0.dequeueReusableCell(withReuseIdentifier: "MainCVCell00", for: indexPath) as! MainCVCell00
            
            guard let product = brandInfo[indexPath.row].products else {return cell}
            cell.brandMainImg.imageFromUrl(brandInfo[indexPath.row].mainfeed_url, defaultImgPath: "")
            cell.brandMainImg.tag = indexPath.row
            cell.brandName.text = brandInfo[indexPath.row].name_english

            
            cell.productImg1.imageFromUrl(product[0].image_url, defaultImgPath: "")
            cell.productImg2.imageFromUrl(product[1].image_url, defaultImgPath: "")
            cell.productImg3.imageFromUrl(product[2].image_url, defaultImgPath: "")
            cell.productImg1.tag = 3 * indexPath.row
            cell.productImg2.tag = 3 * indexPath.row + 1
            cell.productImg3.tag = 3 * indexPath.row + 2
            cell.productLB1.text = product[0].price
            cell.productLB2.text = product[1].price
            cell.productLB3.text = product[2].price
            
            let mainTap = UITapGestureRecognizer(target: self, action: #selector(mainTapped(tapGestureRecognizer:)))
            let product1Tap = UITapGestureRecognizer(target: self, action: #selector(product1Tapped(tapGestureRecognizer:)))
            let product2Tap = UITapGestureRecognizer(target: self, action: #selector(product2Tapped(tapGestureRecognizer:)))
            let product3Tap = UITapGestureRecognizer(target: self, action: #selector(product3Tapped(tapGestureRecognizer:)))
            
            cell.brandMainImg.addGestureRecognizer(mainTap)
            cell.brandMainImg.isUserInteractionEnabled = true
            cell.productImg1.addGestureRecognizer(product1Tap)
            cell.productImg1.isUserInteractionEnabled = true
            cell.productImg2.addGestureRecognizer(product2Tap)
            cell.productImg2.isUserInteractionEnabled = true
            cell.productImg3.addGestureRecognizer(product3Tap)
            cell.productImg3.isUserInteractionEnabled = true

            return cell
    
    }

 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 375, height: 526)
    }
    
    //Mark: - Detect Page changing
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let number =  round(scrollView.contentOffset.x / scrollView.frame.size.width)
        let x = CGFloat(number) * 113
        pagerLeftCons?.constant = x
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.pagerView.layoutIfNeeded();
        }, completion: nil)
        
    }
    
    
    @objc func mainTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        delegate?.mainBrandPressed(cell: self, idx: (tapGestureRecognizer.view?.tag)!)
    }
    
    @objc func product1Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        delegate?.brandProductsPressed(cell: self, idx: (tapGestureRecognizer.view?.tag)!)
    }
    @objc func product2Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        delegate?.brandProductsPressed(cell: self, idx: (tapGestureRecognizer.view?.tag)!)
    }
    @objc func product3Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        delegate?.brandProductsPressed(cell: self, idx: (tapGestureRecognizer.view?.tag)!)
    }


    
    
}

 


    






