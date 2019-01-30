//
//  BrandButton.swift
//  Befit
//
//  Created by 이충신 on 30/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class BrandButton: UIButton {
    
    let gender: String
    let title: String
    var image: UIImage?
    let idx: Int
    let brandIdx: Int
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                super.imageView?.image = gender == "남성" ? menSelected[idx] : womenSelected[idx]
            } else {
                super.imageView?.image = gender == "남성" ? menUnselected[idx] : womenUnselected[idx]
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required init(gender: String, title: String, image: UIImage?, index: Int, brandIdx: Int) {
       
        self.gender = gender
        self.title = title
        self.image = image
        self.idx = index
        self.brandIdx = brandIdx
        
        super.init(frame: .zero)
        
        super.imageView?.image = image
    }
    

    
    static func menButton() -> [BrandButton] {
        return [
            BrandButton(gender: "남성", title: "THISISNEVERTHAT", image: #imageLiteral(resourceName: "manThisisneverthat"), index: 0, brandIdx: 17),
            BrandButton(gender: "남성", title: "ROMANTIC CROWN", image: #imageLiteral(resourceName: "manRomanticcrown"), index: 1, brandIdx: 12),
            BrandButton(gender: "남성", title: "IST KUNST", image: #imageLiteral(resourceName: "manIstkunst"), index: 2, brandIdx: 18),
            BrandButton(gender: "남성", title: "LIBERTENG", image: #imageLiteral(resourceName: "manLiberteng"), index: 3, brandIdx: 10),
            BrandButton(gender: "남성", title: "COVERNAT", image: #imageLiteral(resourceName: "manCovernat"), index: 4, brandIdx: 7),
            BrandButton(gender: "남성", title: "ANDERSSON BELL", image: #imageLiteral(resourceName: "manAnderssonbell"), index: 5, brandIdx: 9),
            BrandButton(gender: "남성", title: "INSILENCE", image: #imageLiteral(resourceName: "manInsilence"), index: 6, brandIdx: 22),
            BrandButton(gender: "남성", title: "CRITIC", image: #imageLiteral(resourceName: "manCritic") ,index: 7, brandIdx: 14)
        
        ]
    }
    
    static func womenButton() -> [BrandButton] {
        return [
            BrandButton(gender: "여성", title: "THISISNEVERTHAT", image: #imageLiteral(resourceName: "womanThisisneverthat"), index: 0, brandIdx: 17),
            BrandButton(gender: "여성", title: "ROMANTIC CROWN", image: #imageLiteral(resourceName: "womanRomanticCrwon"), index: 1, brandIdx: 12),
            BrandButton(gender: "여성", title: "MINAV", image: #imageLiteral(resourceName: "womanMinav"), index: 2, brandIdx: 2),
            BrandButton(gender: "여성", title: "LAFUDGESTORE", image: #imageLiteral(resourceName: "womanLafudgestore"), index: 3, brandIdx: 3),
            BrandButton(gender: "여성", title: "MORE OR LESS", image: #imageLiteral(resourceName: "womanMoreOrLess"), index: 4, brandIdx: 32),
            BrandButton(gender: "여성", title: "ANDERSSON BELL", image: #imageLiteral(resourceName: "womanAnderssonBell"), index: 5, brandIdx: 9),
            BrandButton(gender: "여성", title: "OiOi", image: #imageLiteral(resourceName: "womanOioi"), index: 6, brandIdx: 37),
            BrandButton(gender: "여성", title: "CRITIC", image: #imageLiteral(resourceName: "womanCritic") ,index: 7, brandIdx: 14)
        ]
    }
    
}

let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]

let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
var womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]

//남성:
//0. THISISNEVERTHAT 17.
//1. ROMANTIC CROWN 12
//2. IST KUNST 18
//3. LIBERTENG 10
//4. COVERNAT 7
//5. ANDERSSON BELL 9
//6. INSILENCE 22
//7. CRITIC 14

//여성:
//0. THISISNEVERTHAT 17
//1. ROMANTIC CROWN 12
//2. MINAV 2    ***************
//3. LAFUDGESTORE 3   ***************
//4. MORE OR LESS 32   ***************
//5. ANDERSSON BELL 9
//6. OiOi 37     ***************
//7. CRITIC 14
