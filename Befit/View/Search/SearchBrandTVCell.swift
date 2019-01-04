//
//  SearchBrandTVCell.swift
//  Befit
//
//  Created by 이충신 on 29/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class SearchBrandTVCell: UITableViewCell {

    @IBOutlet weak var brandImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
