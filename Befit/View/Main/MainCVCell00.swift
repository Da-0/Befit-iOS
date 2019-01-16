//
//  MainCVCell00.swift
//  Befit
//
//  Created by 이충신 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

//protocol customCellDelgate2 : class {
//     func sharePressed(cell: MainCVCell00)
//}

class MainCVCell00: UICollectionViewCell {
    
    @IBOutlet weak var brandMainImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    
    @IBOutlet weak var productImg1: UIImageView!
    @IBOutlet weak var productImg2: UIImageView!
    @IBOutlet weak var productImg3: UIImageView!
    
    @IBOutlet weak var productLB1: UILabel!
    @IBOutlet weak var productLB2: UILabel!
    @IBOutlet weak var productLB3: UILabel!
    
//    var delegate: customCellDelgate2?

    override func awakeFromNib() {
        super.awakeFromNib()
//        delegate?.sharePressed(cell: self)
        
    }
    
}






