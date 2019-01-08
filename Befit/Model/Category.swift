//
//  Model.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

struct Category {

    let title: String
    let image: UIImage?
    let idx: Int
    
    init( title: String, image: UIImage?, index: Int) {
        self.image = image
        self.title = title
        self.idx = index
    }
    
    static func allmen() -> [Category] {
        return [
            Category(title: "Outer", image: #imageLiteral(resourceName: "searchOuter"), index: 0),
            Category(title: "Jacket", image: #imageLiteral(resourceName: "searchJacket"), index: 1),
            Category(title: "Coat", image: #imageLiteral(resourceName: "searchCoat"), index: 2),
            Category(title: "Shirts", image: #imageLiteral(resourceName: "searchShirts"), index: 3),
            Category(title: "Knits", image: #imageLiteral(resourceName: "searchKnits"), index: 4),
            Category(title: "Hoody", image: #imageLiteral(resourceName: "searchHoody"), index: 5),
            Category(title: "Sweat Shirts", image: #imageLiteral(resourceName: "searchSweatShirts"), index: 6),
            Category(title: "T-Shirts", image: #imageLiteral(resourceName: "searchTShirts") ,index: 7),
            Category(title: "Jeans", image: #imageLiteral(resourceName: "searchJean"), index: 9),
            Category(title: "Pants", image: #imageLiteral(resourceName: "searchPants"), index: 10),
            Category(title: "Slacks", image: #imageLiteral(resourceName: "searchSlacks"), index: 11),
            Category(title: "Short-Pants", image: #imageLiteral(resourceName: "searchShortPants"), index: 12)
        
        ]
    }
    
    static func allwomen() -> [Category] {
        return [
            Category(title: "Outer", image: #imageLiteral(resourceName: "searchOuter"), index: 0),
            Category(title: "Jacket", image: #imageLiteral(resourceName: "searchJacket"), index: 1),
            Category(title: "Coat", image: #imageLiteral(resourceName: "searchCoat"), index: 2 ),
            Category(title: "Shirts", image: #imageLiteral(resourceName: "searchShirts"), index: 3),
            Category(title: "Knits", image: #imageLiteral(resourceName: "searchKnits"), index: 4),
            Category(title: "Hoody", image: #imageLiteral(resourceName: "searchHoody"), index: 5),
            Category(title: "Sweat Shirts", image: #imageLiteral(resourceName: "searchSweatShirts"), index: 6),
            Category(title: "T-Shirts", image: #imageLiteral(resourceName: "searchTShirts"), index: 7),
            Category(title: "OnePiece", image: #imageLiteral(resourceName: "searchDress"), index: 8),
            Category(title: "Jeans", image: #imageLiteral(resourceName: "searchJean"), index: 9),
            Category(title: "Pants", image: #imageLiteral(resourceName: "searchPants"), index: 10),
            Category(title: "Slacks", image: #imageLiteral(resourceName: "searchSlacks"), index: 11),
            Category(title: "Short-Pants", image: #imageLiteral(resourceName: "searchShortPants"), index: 12),
            Category(title: "Skirts", image: #imageLiteral(resourceName: "searchSkirs"), index: 13)
        ]
    }
    
    
    
    
}
