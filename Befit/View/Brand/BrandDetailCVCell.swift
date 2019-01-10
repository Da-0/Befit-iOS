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
    
//
//    @IBAction func populBtnAction(_ sender: UIButton) {
//
//        PopularBtn.setImage(#imageLiteral(resourceName: "manSelectRomanticcrown"), for: .normal)
//        NewBtn.setImage(#imageLiteral(resourceName: "red off"), for: .normal)
//
//    }
    @IBAction func popularAction(_ sender: Any) {
        
        NewBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        PopularBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
        //***인기순 데이터를 호출하는 통신 구현부***
        ///////////////////////////////////
        
    }
    @IBAction func newAction(_ sender: Any) {
        
        PopularBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        NewBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
        //***최신순 데이터를 호출하는 통신 구현부***
        ///////////////////////////////////
        
        
    }
    
    
}
