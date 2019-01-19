//
//  ChangeBrandVC.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.storyboard
//  선호브랜드 재선택 뷰

//남,여 Tag 번호에 따른 실제 브랜드 Idx

//남성:
//0. THISISNEVERTHAT 17.
//1. ROMANTIC CROWN 12
//2. IST KUNST 18
//3. LIBERTENG 10
//4. COVERNAT 7
//5. ANDERSSON BELL 9
//6. INSILENCE 22
//7. CRITIC 14

//여성:
//0. THISISNEVERTHAT 17
//1. ROMANTIC CROWN 12
//2. MINAV 2    ***************
//3. LAFUDGESTORE 3   ***************
//4. MORE OR LESS 32   ***************
//5. ANDERSSON BELL 9
//6. OiOi 37     ***************
//7. CRITIC 14

import UIKit

class ChangeBrandVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    var btnArray: [UIButton] = [UIButton]()
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    var brandIdx: [Int] = []
    var gender: String?
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    //Buttons Images
    let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
    var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]
    let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
    var womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]
    var selectedCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = false
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
            
            if gender == "남성" {
                btn.setImage(menUnselected[btn.tag], for: .normal)
            }
            else {
                btn.setImage(womenUnselected[btn.tag], for: .normal)
                menSelected = womenSelected
            }
        }
        
       for selected in brandIdx {
            
            switch selected {
                
                case 17:
                    btnArray[0].setImage(menSelected[0], for: .selected)
                    btnArray[0].isSelected = true
                case 12:
                    btnArray[1].setImage(menSelected[1], for: .selected)
                     btnArray[1].isSelected = true
                case 2,18:
                    btnArray[2].setImage(menSelected[2], for: .selected)
                     btnArray[2].isSelected = true
                case 10,3:
                    btnArray[3].setImage(menSelected[3], for: .selected)
                     btnArray[3].isSelected = true
                case 7,32 :
                    btnArray[4].setImage(menSelected[4], for: .selected)
                     btnArray[4].isSelected = true
                case 9:
                    btnArray[5].setImage(menSelected[5], for: .selected)
                     btnArray[5].isSelected = true
                case 22,37:
                    btnArray[6].setImage(menSelected[6], for: .selected)
                     btnArray[6].isSelected = true
                case 14:
                    btnArray[7].setImage(menSelected[7], for: .selected)
                     btnArray[7].isSelected = true
                default: break
                
            }
        }
   
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        if selectedCount == 2 {
        
            ChangeBrandService.shared.setBrand(brand1: brandIdx[0], brand2: brandIdx[1]) { (res) in
                if let status = res.status {
                    switch status {
                        case 200 :
                            self.navigationController?.popViewController(animated: true)
                        case 204, 401, 500, 600:
                            self.simpleAlert(title: "Error", message: res.message!)
                        default: break
                    }
                }
                
            }
            
          
            
        }
     
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        if selectedCount != 2 {
            
            if sender.isSelected == false {
                sender.setImage(menSelected[sender.tag], for: .selected)
                sender.isSelected = true
                
                let selected = gender == "남성"
                
                switch sender.tag {
                case 0:
                    brandIdx.append(17)
                    break
                case 1:
                    brandIdx.append(12)
                    break
                case 2:
                    selected ? brandIdx.append(18) : brandIdx.append(2)
                    break
                case 3:
                    selected ? brandIdx.append(10) : brandIdx.append(3)
                    break
                case 4:
                    selected ? brandIdx.append(7) : brandIdx.append(32)
                    break
                case 5:
                    brandIdx.append(9)
                    break
                case 6:
                    selected ? brandIdx.append(22) : brandIdx.append(37)
                    break
                case 7:
                    brandIdx.append(14)
                    break
                default: break
                }
                
                selectedCount += 1
                
                if selectedCount == 2 {
                    backBtn.isEnabled = true
                
                }
                
            }
                
            else{
                sender.setImage(menUnselected[sender.tag], for: .selected)
                sender.isSelected = false
                brandIdx.removeLast()
                selectedCount -= 1
            }
            
        }
            
        else {
            
            if sender.isSelected == true{
                sender.imageView!.image = menUnselected[sender.tag]
                sender.isSelected = false
                brandIdx.removeLast()
                selectedCount -= 1
                backBtn.isEnabled = false
                
            }
        }
    }
    
}











