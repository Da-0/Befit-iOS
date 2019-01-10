//
//  BrandDetailCVCell.swift
//  Befit
//
//  Created by 박다영 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

//protocol btnActionDelegate: class {
//    func pressBtn(_ cell: BrandDetailCVCell)
//}

//protocol btnActionDelegate: class {
//    func btnTapped(tag: Int)
//}

class BrandDetailCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var brandBackGround: UIImageView!
    @IBOutlet weak var BrandLogoImg: UIImageView!
    
    @IBOutlet weak var BrandNameEndglishLB: UILabel!
    @IBOutlet weak var BrandNameKoreanLB: UILabel!
    @IBOutlet weak var LikeBtn: UIButton!
    
    @IBOutlet weak var ProductNumLB: UILabel!
    
    @IBOutlet weak var PopularBtn: UIButton!
    @IBOutlet weak var NewBtn: UIButton!
    
    
    @IBAction func populBtnAction(_ sender: UIButton) {
        
        PopularBtn.setImage(#imageLiteral(resourceName: "green on"), for: .normal)
        NewBtn.setImage(#imageLiteral(resourceName: "red off"), for: .normal)
        
    }
    
    
    
}
