//
//  UserInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
// 브랜드 선택 뷰

import UIKit

class UserInfoVC2: UIViewController {
    
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
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageLB: UILabel!
    
    var brandIdx: [Int] = []
    var gender: String?
    
    //Buttons Images
    let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
    var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]
    let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
    var womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]
    var selectedCount = 0
    
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
            
            if gender == "남성" {
                btn.setImage(menUnselected[btn.tag], for: .normal)
            }
            else {
                btn.setImage(womenUnselected[btn.tag], for: .normal)
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
                    nextBtn.setImage( #imageLiteral(resourceName: "icPurplearrow"), for: .normal)
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
                nextBtn.setImage( #imageLiteral(resourceName: "icGrayarrow"), for: .normal)
                
            }
        }
    }
    
    // 다음 버튼 누를 때 선택된 카운트가 2일 경우에만 가능
    @IBAction func nextAction(_ sender: Any) {
        
        if selectedCount == 2 {
            
//            print(brandIdx)
            
            userDefault.set(brandIdx[0], forKey: "brand1_idx")
            userDefault.set(brandIdx[1], forKey: "brand2_idx")
            
            let logIn = UIStoryboard.init(name: "LogIn", bundle: nil)
            let userInfoVC3 = logIn.instantiateViewController(withIdentifier: "UserInfoVC3") as? UserInfoVC3
            userInfoVC3?.gender = self.gender
            self.navigationController?.pushViewController(userInfoVC3!, animated: true)
            
        }
        
        
    }

}
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



