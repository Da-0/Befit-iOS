//
//  PBrandDetailCVCell2.swift
//  Befit
//
//  Created by 이충신 on 17/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class PBrandDetailCVCell2: UICollectionViewCell {
    
    //중간 상품 정보 뿌분
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var likeBtn2: UIButton!
    
    @IBOutlet weak var productView: UIView!
    
    //Header Cell 부분
    @IBOutlet weak var productNumLB: UILabel!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var popularBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.productView.layer.borderWidth = 1.0
    }
    
    
    @IBAction func popularAction(_ sender: Any) {
        
        newBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        popularBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
    }
    
    @IBAction func newAction(_ sender: Any) {
        
        popularBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        newBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
    }
}
