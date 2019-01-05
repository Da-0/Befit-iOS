//
//  SizeItems.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

struct SizeItems {
    
    let brandName: String?
    let productName: String?
    let image: UIImage?
    
    init(image: UIImage?, brand: String?, product: String?) {
        self.image = image
        self.brandName = brand
        self.productName = product
    }
    
    
}
