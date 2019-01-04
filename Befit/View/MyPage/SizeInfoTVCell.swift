//
//  SizeInfoTVCell.swift
//  Befit
//
//  Created by 이충신 on 01/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class SizeInfoTVCell: UITableViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    func configureForCategory(_ category: Category) {
        categoryImg.image = category.image
        categoryName.text = category.title
    }

}
