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
    
    init( title: String, image: UIImage?) {
        self.image = image
        self.title = title
    }
    
    static func allmen() -> [Category] {
        return [
            Category(title: "Outer", image: #imageLiteral(resourceName: "searchOuter")),
            Category(title: "Jacket", image: #imageLiteral(resourceName: "searchJacket")),
            Category(title: "Coat", image: #imageLiteral(resourceName: "searchCoat") ),
            Category(title: "Shirts", image: #imageLiteral(resourceName: "searchShirts")),
            Category(title: "Knits", image: #imageLiteral(resourceName: "searchKnits")),
            Category(title: "Hoody", image: #imageLiteral(resourceName: "searchHoody")),
            Category(title: "Sweat Shirts", image: #imageLiteral(resourceName: "searchSweatShirts")),
            Category(title: "T-Shirts", image: #imageLiteral(resourceName: "searchTShirts")),
            Category(title: "Jeans", image: #imageLiteral(resourceName: "searchJean")),
            Category(title: "Pants", image: #imageLiteral(resourceName: "searchPants")),
            Category(title: "Slacks", image: #imageLiteral(resourceName: "searchSlacks")),
            Category(title: "Short-Pants", image: #imageLiteral(resourceName: "searchShortPants"))
        
        ]
    }
    
    static func allwomen() -> [Category] {
        return [
            Category(title: "Outer", image: #imageLiteral(resourceName: "searchOuter")),
            Category(title: "Jacket", image: #imageLiteral(resourceName: "searchJacket")),
            Category(title: "Coat", image: #imageLiteral(resourceName: "searchCoat") ),
            Category(title: "Shirts", image: #imageLiteral(resourceName: "searchShirts")),
            Category(title: "Knits", image: #imageLiteral(resourceName: "searchKnits")),
            Category(title: "Hoody", image: #imageLiteral(resourceName: "searchHoody")),
            Category(title: "Sweat Shirts", image: #imageLiteral(resourceName: "searchSweatShirts")),
            Category(title: "T-Shirts", image: #imageLiteral(resourceName: "searchTShirts")),
            Category(title: "OnePiece", image: #imageLiteral(resourceName: "searchDress")),
            Category(title: "Jeans", image: #imageLiteral(resourceName: "searchJean")),
            Category(title: "Pants", image: #imageLiteral(resourceName: "searchPants")),
            Category(title: "Slacks", image: #imageLiteral(resourceName: "searchSlacks")),
            Category(title: "Short-Pants", image: #imageLiteral(resourceName: "searchShortPants")),
            Category(title: "Skirts", image: #imageLiteral(resourceName: "searchSkirs"))
        ]
    }
    
    
    
    
}
