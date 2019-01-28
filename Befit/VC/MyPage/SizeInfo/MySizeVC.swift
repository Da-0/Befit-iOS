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

    @IBOutlet weak var LB00: UILabel!
    @IBOutlet weak var LB01: UILabel!
    @IBOutlet weak var LB02: UILabel!
    @IBOutlet weak var LB03: UILabel!
    @IBOutlet weak var LB04: UILabel!
    var LB0Array: [UILabel] = []
    
    @IBOutlet weak var LB10: UILabel!
    @IBOutlet weak var LB11: UILabel!
    @IBOutlet weak var LB12: UILabel!
    @IBOutlet weak var LB13: UILabel!
    @IBOutlet weak var LB14: UILabel!
    var LB1Array: [UILabel] = []
    
    @IBOutlet weak var fourthStack: UIStackView!
    @IBOutlet weak var fifthStack: UIStackView!
    
    var keyCount: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
    
    func setLabel(){
        
        LB0Array.append(LB00)
        LB0Array.append(LB01)
        LB0Array.append(LB02)
        LB0Array.append(LB03)
        LB0Array.append(LB04)
        
        LB1Array.append(LB10)
        LB1Array.append(LB11)
        LB1Array.append(LB12)
        LB1Array.append(LB13)
        LB1Array.append(LB14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        network()

    
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
            
            //싱단 기본정보 (이미지, 이름, 사이즈)
            self.productImg.imageFromUrl(data.image_url!, defaultImgPath: "")
            self.brandName.text = data.name_english
            self.productName.text = data.name
            self.size.text = data.product_size
            
            //하단 측정치 정보
          
            guard let keys = data.measure2?.toJSON().keys else {return}
            guard let values = data.measure2?.toJSON().values else {return}
            
            print("<등록된 내 사이즈 정보>")
            print("\n 측정지 값들 = " + "\(data.measure2!)")
            print("\n 추출 Key값들 =  \(keys)")
            print("\n 추출 Value값들 =  \(values)")
            
            if keys.count == 3 {
                self.fourthStack.isHidden = true
            self.fifthStack.isHidden = true
            }
            if keys.count == 4 {
                self.fifthStack.isHidden = true
            }
            
            for (idx, val) in values.enumerated() {
                self.LB1Array[idx].text = val as? String
            }
        
            
            for (idx, key) in keys.enumerated() {
                
                switch key {
                    case "chestSection":
                        self.LB0Array[idx].text = BodyPart.chest.rawValue
                        break
                    case "totalLength":
                        self.LB0Array[idx].text = BodyPart.total.rawValue
                        break
                    case "shoulderWidth":
                        self.LB0Array[idx].text = BodyPart.shoulder.rawValue
                        break
                    case "sleeveLength":
                        self.LB0Array[idx].text = BodyPart.sleeve.rawValue
                        break
                    case "waistSection":
                        self.LB0Array[idx].text = BodyPart.waist.rawValue
                        break
                    case "thighSection":
                        self.LB0Array[idx].text = BodyPart.thigh.rawValue
                        break
                    case "crotch":
                        self.LB0Array[idx].text = BodyPart.crotch.rawValue
                        break
                    case "dobladilloSection":
                        self.LB0Array[idx].text = BodyPart.dobla.rawValue
                        break
                    default:
                    break
                }
                
            }
        
        })
    }


    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}


