//
//  DescriptionVC.swift
//  Befit
//
//  Created by 박다영 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  LogIn.Storyboard
//  0) 처음 앱 설치시 나오는 설명 스크롤 VC

import UIKit

class DescriptionVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = ["info1", "info2", "info3", "info4"]

    var enterBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "startButton"), for: .normal)
        btn.addTarget(self, action: #selector(startBtnTabbed), for: .touchUpInside)
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
            
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i) 
            
            imageView.frame = CGRect(x: xPosition, y: -44, width: self.view.frame.width, height: self.view.frame.height)
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            scrollView.addSubview(imageView)
            
            if i == 3 {
                //enterBtn.frame = CGRect(x:1249, y:650, width:127, height:36)
                enterBtn.frame = CGRect(x:1249, y:  550 , width:120, height: 30)
                scrollView.addSubview(enterBtn)
            }
            
            
        }
    }
    
    
    
    
    

    @objc func startBtnTabbed (){
        let loginVC = Storyboard.shared().login.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC

        self.present(loginVC, animated: true, completion: nil)
        
    }


}
