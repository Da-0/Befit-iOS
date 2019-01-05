//
//  SearchVC1.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit
import SNCollectionViewLayout

class SearchVC1: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        initSNCollection()
    }
    
    func initSNCollection() {
    
        let snCollectionViewLayout = SNCollectionViewLayout()
        snCollectionViewLayout.delegate = self;
        snCollectionViewLayout.fixedDivisionCount = 6
        collectionView.collectionViewLayout = snCollectionViewLayout
        
    }

}

extension SearchVC1: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let searchCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as! SearchCVCell
        
        searchCVCell.productImg.image = #imageLiteral(resourceName: "testImage")
        
        return searchCVCell
    }

}


extension SearchVC1: SNCollectionViewLayoutDelegate {
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        
        if indexPath.row == 0 || indexPath.row == 9 || indexPath.row == 16 {
            return 4
        }
        else if indexPath.row % 8 == 6 || indexPath.row % 8 == 7  {
            return 3
        }
        
        return 2
    }
    
    
}
