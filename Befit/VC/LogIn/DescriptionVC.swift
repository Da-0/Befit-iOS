//
//  DescriptionVC.swift
//  Befit
//
//  Created by 박다영 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = ["info1", "info2", "info3", "info4"]

    var enterBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "startButton"), for: .normal)
        btn.addTarget(self, action: #selector(downBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setting()
    }
    
    func setting(){
        
        for i in 0..<images.count {
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            
            imageView.contentMode = .scaleAspectFit //  사진의 비율을 맞춤.
            let xPosition = self.view.frame.width * CGFloat(i) // 현재 보이는 스크린에서 하나의 이미지만 보이게 하기 위해
            
            imageView.frame = CGRect(x: xPosition, y: -44, width: self.view.frame.width, height: self.view.frame.height)
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            scrollView.addSubview(imageView)
            
            if i == 3 {
                enterBtn.frame = CGRect(x:1249, y:650, width:127, height:36)
                scrollView.addSubview(enterBtn)
            }
            
            
        }
    }
    
    
    
    
    

    @objc func downBtnTapped (){
        let loginVC = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInVC") as! LogInVC

        self.present(loginVC, animated: true, completion: nil)
        
    }


}
