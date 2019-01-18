//
//  MainCVCell1.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

protocol customCellDelegate2: class {
    func bannerPressed(cell: MainCVCell1, idx: Int)
}

class MainCVCell1: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    let imageArray = [#imageLiteral(resourceName: "banner0"), #imageLiteral(resourceName: "banner1"), #imageLiteral(resourceName: "banner2")]
    
    var timer: Timer!
    
    var delegate: customCellDelegate2?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView1.delegate = self;
        collectionView1.dataSource = self;
        collectionView1.reloadData()
        
       self.startTimer()
        
    }
    

    func startTimer() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
    }
    
    @objc func scrollToNextCell(){
    
        let cellSize = CGSize(width: 375, height: 90)
        
        let contentOffset = collectionView1.contentOffset;
        
        if collectionView1.contentSize.width <= collectionView1.contentOffset.x + cellSize.width
        {
            collectionView1.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
            
        } else {
            collectionView1.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "MainCVCell11", for: indexPath) as! MainCVCell11
        cell.bannerImage.tag = indexPath.row
        cell.bannerImage.image = imageArray[indexPath.row]
        
        cell.bannerImage.isUserInteractionEnabled = true
        let bannerTap = UITapGestureRecognizer(target: self, action: #selector(bannerTapped(tapGestureRecognizer:)))
        cell.bannerImage.addGestureRecognizer(bannerTap)
        return cell
    }
    
    @objc func bannerTapped(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.bannerPressed(cell: self, idx: (tapGestureRecognizer.view?.tag)!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 90)
    }

    
        
}
    
    

