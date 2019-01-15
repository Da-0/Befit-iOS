//
//  UserInfoVC2.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.Storyboard
//  1)회원가입 단계에서 성별을 선택하는 뷰

import UIKit

class UserInfoVC1: UIViewController {

    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var selected: Bool!
    var gender: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
    }

    //성별 선택시 이미지 변환
    @IBAction func womanBtn(_ sender: Any) {
        
        if !womanBtn.isSelected {
            womanBtn.isSelected = true
            womanBtn.setImage(#imageLiteral(resourceName: "icWomanTouch"), for: .selected)
            nextBtn.setImage(#imageLiteral(resourceName: "icPurplearrow"), for: .normal)
            manBtn.setImage(#imageLiteral(resourceName: "icManNotouch"), for: .selected)
            manBtn.isSelected = false
            gender = "여성"
        }
        else{
            womanBtn.isSelected = false
            womanBtn.setImage(#imageLiteral(resourceName: "icWomanNotouch"), for: .selected)
            nextBtn.setImage(#imageLiteral(resourceName: "icGrayarrow"), for: .normal)
        }
    }
    
    @IBAction func manBtn(_ sender: Any) {
        
        if !manBtn.isSelected {
            manBtn.isSelected = true
            manBtn.setImage(#imageLiteral(resourceName: "icManTouch"), for: .selected)
            nextBtn.setImage(#imageLiteral(resourceName: "icPurplearrow"), for: .normal)
            womanBtn.setImage(#imageLiteral(resourceName: "icWomanNotouch"), for: .selected)
            womanBtn.isSelected = false
            gender = "남성"
        }
        else{
            manBtn.isSelected = false
            manBtn.setImage(#imageLiteral(resourceName: "icManNotouch"), for: .selected)
            nextBtn.setImage(#imageLiteral(resourceName: "icGrayarrow"), for: .normal)
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if manBtn.isSelected || womanBtn.isSelected {
            let logIn = UIStoryboard.init(name: "LogIn", bundle: nil)
            let userInfoVC2 = logIn.instantiateViewController(withIdentifier: "UserInfoVC2") as! UserInfoVC2
            userInfoVC2.gender = self.gender
            self.navigationController?.pushViewController(userInfoVC2, animated: true)
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    func navigationBarSetting(){
        self.navigationController!.navigationBar.barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
}

