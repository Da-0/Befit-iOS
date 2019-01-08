//
//  SearchCRV.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class SearchCRV: UICollectionReusableView {
        
    @IBOutlet weak var popularBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    
    
    @IBAction func popularAction(_ sender: Any) {
        
        newBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        popularBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
        //***인기순 데이터를 호출하는 통신 구현부***
        ///////////////////////////////////
        
    }
    @IBAction func newAction(_ sender: Any) {
        
        popularBtn.setTitleColor(#colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1), for: .normal)
        newBtn.setTitleColor(#colorLiteral(red: 0.5169706941, green: 0.1907331347, blue: 0.9285635948, alpha: 1), for: .normal)
        
        //***최신순 데이터를 호출하는 통신 구현부***
        ///////////////////////////////////
        
        
    }
    
    
    
    
}
