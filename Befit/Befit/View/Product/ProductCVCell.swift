//
//  ProductCVCell.swift
//  Befit
//
//  Created by 이충신 on 18/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class ProductCVCell: UICollectionViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropShadow()
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 4.0
        //self.layer.cornerRadius = 5.0
    }
    
}
