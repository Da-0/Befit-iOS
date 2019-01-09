//
//  CollectionViewCell.swift
//  For-Dayoung
//
//  Created by LeeSeungsoo on 09/01/2019.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var alphabet: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                alphabet.textColor = #colorLiteral(red: 0.4784313725, green: 0.2117647059, blue: 0.8941176471, alpha: 1)
            } else {
                alphabet.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
            }
        }
    }
}
