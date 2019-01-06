//
//  UserInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class UserInfoVC2: UIViewController {
    
    var btnArray: [UIButton] = [UIButton]()
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    //Buttons Images
    let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
    var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]
    let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
    var womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]
    var selectedCount = 0

    let gender = UserDefaults.standard.string(forKey: "gender")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBtn()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func initBtn(){
        
        btnArray.append(btn0)
        btnArray.append(btn1)
        btnArray.append(btn2)
        btnArray.append(btn3)
        btnArray.append(btn4)
        btnArray.append(btn5)
        btnArray.append(btn6)
        btnArray.append(btn7)
        
        for btn in btnArray {
            print(btn.tag)
            if gender == "남" { btn.setImage(menUnselected[btn.tag], for: .normal)}
            else {btn.setImage(womenUnselected[btn.tag], for: .normal)
                menSelected = womenSelected
            }
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {

        if selectedCount != 2 {
            
            if sender.isSelected == false {
                sender.setImage(menSelected[sender.tag], for: .selected)
                sender.isSelected = true
                selectedCount += 1
                
                if selectedCount == 2 {
                    nextBtn.setImage(#imageLiteral(resourceName: "icPurplearrow"), for: .normal)
                }
                
            }
                
            else{
                sender.setImage(menUnselected[sender.tag], for: .selected)
                sender.isSelected = false
                selectedCount -= 1
            }
            
        }
         
        else {
            
            if sender.isSelected == true{
                sender.imageView!.image = menUnselected[sender.tag]
                sender.isSelected = false
                selectedCount -= 1
                nextBtn.setImage(#imageLiteral(resourceName: "icGrayarrow"), for: .normal)
                
            }
        }
    }
    
    // 다음 버튼 누를 때 선택된 카운트가 2일 경우에만 가능
    @IBAction func nextAction(_ sender: Any) {
        
        if selectedCount == 2 {
            let logIn = UIStoryboard.init(name: "LogIn", bundle: nil)
            let userInfoVC1 = logIn.instantiateViewController(withIdentifier: "UserInfoVC1") as? UserInfoVC11
            self.navigationController?.pushViewController(userInfoVC1!, animated: true)
            
        }
    }
}
