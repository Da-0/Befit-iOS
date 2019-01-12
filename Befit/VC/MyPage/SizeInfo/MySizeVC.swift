//
//  MySizeVC.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class MySizeVC: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var size: UILabel!
    var closetIdx: Int?

    @IBOutlet weak var LB1: UILabel!
    @IBOutlet weak var LB2: UILabel!
    @IBOutlet weak var LB3: UILabel!
    @IBOutlet weak var LB4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        network()
        randomValue()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func network(){
        
        GetClosetDetailService.shared.showClosetDetail(idx: closetIdx!, completion: {[weak self] (res) in
            guard let `self` = self else {return}
            guard let data = res.data else {return}
            
            //싱딘 기본정보 (이미지, 이름, 사이즈)
            self.productImg.imageFromUrl(data.image_url!, defaultImgPath: "")
            self.brandName.text = data.name_english
            self.productName.text = data.name
            self.size.text = data.product_size
            
            //하단 측정치 정보
        
            
        })
    }


    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}


extension MySizeVC {
    
    func randomValue(){
    
        LB1.text = "\(Int.random(in: 55...70))"
        LB2.text = "\(Int.random(in: 50...65))"
        LB3.text = "\(Int.random(in: 32...45))"
        LB4.text = "\(Int.random(in: 40...55))"
        
    }
    
    
    
    
    
    
}
