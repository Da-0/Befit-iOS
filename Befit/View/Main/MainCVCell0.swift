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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView0.dequeueReusableCell(withReuseIdentifier: "MainCVCell00", for: indexPath) as! MainCVCell00

        return cell
    }
    


    
    
}
