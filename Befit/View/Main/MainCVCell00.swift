//
//  MainCVCell00.swift
//  Befit
//
//  Created by 이충신 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class MainCVCell00: UICollectionViewCell {
    
    
    @IBOutlet weak var brandMainImg: UIImageView!
    
    @IBOutlet weak var productImg1: UIImageView!
    @IBOutlet weak var productImg2: UIImageView!
    @IBOutlet weak var productImg3: UIImageView!
    
    @IBOutlet weak var productLB1: UILabel!
    @IBOutlet weak var productLB2: UILabel!
    @IBOutlet weak var productLB3: UILabel!
    
    override func awakeFromNib() {
        
        productImg1.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        productImg1.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        
        
        
        
        
    }
    
    
    
    
    
}
