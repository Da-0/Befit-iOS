//
//  SizeInfo2CVCell.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

protocol SizeInfo2CellDelegate: class {
    func delete(cell: SizeInfo2CVCell)
}


class SizeInfo2CVCell: UICollectionViewCell {
    
    weak var delegate: SizeInfo2CellDelegate?
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var alphaView: UIView!
    
    var isEditing: Bool = false {
        didSet{
            alphaView.isHidden = !isEditing
        }
    }
    
    @IBAction func deletBtnAction(_ sender: Any) {
        delegate?.delete(cell: self)
    }
}
