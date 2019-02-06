//
//  MySizeVC.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  3-6) SizeInfoVC2에서 셀 선택시 나타나는 특정 사이즈 정보

import UIKit

class MySizeVC: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var size: UILabel!
    var bodyPart: BodyPart?
    var closetIdx: Int?

    @IBOutlet var LB0Array: [UILabel]!
    @IBOutlet var LB1Array: [UILabel]!
    
    @IBOutlet weak var fourthStack: UIStackView!
    @IBOutlet weak var fifthStack: UIStackView!
    
    var enrollNewCloset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            //기본정보 (이미지, 이름, 사이즈)
            self.productImg.imageFromUrl2(data.image_url!, defaultImgPath: "")
            self.brandName.text = data.name_english
            self.productName.text = data.name
            self.size.text = data.product_size
            
            //측정치 정보 sorting
            let measureData = Array(data.measure2!.toJSON()).sorted(by: { (first, second) -> Bool in
                
                switch (first.key, second.key) {
                    case ("totalLength", _ ) :
                        return true
                    case (_ ,"totalLength") :
                        return false
                    default: break
                }
                return first.key > second.key
            })
         
            print("\n<등록된 내 사이즈 정보>")
            print("측정지 값들(toJSON) = " + "\(measureData))")
            
            if measureData.count == 3 {
                self.fourthStack.isHidden = true
                self.fifthStack.isHidden = true
            }
            else if measureData.count == 4 {
                self.fourthStack.isHidden = false
                self.fifthStack.isHidden = true
            }
         
            
            for (idx, data) in measureData.enumerated() {
                
                switch data.key{
                    case "totalLength": self.bodyPart = .total
                    case "chestSection": self.bodyPart = .chest
                    case "shoulderWidth": self.bodyPart = .shoulder
                    case "sleeveLength": self.bodyPart = .sleeve
                    case "waistSection": self.bodyPart = .waist
                    case "thighSection": self.bodyPart = .thigh
                    case "crotch": self.bodyPart = .crotch
                    case "dobladillosSection": self.bodyPart = .dobla
                    default: return
                }
                self.LB0Array[idx].text = self.bodyPart?.rawValue
                self.LB1Array[idx].text = data.value as? String
            }
        
        })
    }


    @IBAction func backBtn(_ sender: Any) {
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}


