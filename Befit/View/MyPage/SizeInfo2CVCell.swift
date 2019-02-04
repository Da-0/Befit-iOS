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
    
    override var isUserInteractionEnabled: Bool{
        didSet{
             self.alphaView.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    
    @IBAction func deletBtnAction(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropShadow()
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 4.0
     
    }
}
