//
//  UserInfoVC3.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  LogIn.Storyboard
//  3) 회원가입 단계에서 선호 브랜드를 선택하는 VC

import UIKit

class UserInfoVC2: UIViewController {
    
    //Buttons Images
    let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
    var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]
    let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
    var womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet var btnArray: [UIButton]!
    
    var brandIdx: [Int] = []
    var gender: String?
    var selectedBrand: BrandName!
    
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
        

        for btn in btnArray {
            
            if gender == "남성" {
                btn.setImage(menUnselected[btn.tag], for: .normal)
                btn.setImage(menSelected[btn.tag], for: .selected)
                
            }
            else {
                btn.setImage(womenUnselected[btn.tag], for: .normal)
                btn.setImage(womenSelected[btn.tag], for: .selected)
            }
            
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        if brandIdx.count != 2 {
            if sender.isSelected == false {
                sender.isSelected = true
                self.appendRemoveIdx(true, sender.tag)
            }
            else{
                sender.isSelected = false
                self.appendRemoveIdx(false, sender.tag)
            }
        }
        else {
            
            if sender.isSelected == true {
                sender.isSelected = false
                self.appendRemoveIdx(false, sender.tag)
                
            }
        }
    }
    

    @IBAction func nextAction(_ sender: Any) {
        
        if brandIdx.count == 2 {

            let userInfoVC3 =  UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "UserInfoVC3") as! UserInfoVC3
            
            userInfoVC3.gender = self.gender
            userInfoVC3.brandIdx1 = self.brandIdx[0]
            userInfoVC3.brandIdx2 = self.brandIdx[1]
            
            self.navigationController?.pushViewController(userInfoVC3, animated: true)
            
        }
        
        
    }
    
    func appendRemoveIdx(_ append: Bool, _ tag: Int) {
        
        let selected = gender == "남성"
        
        switch tag {
            case 0:
                selectedBrand = .THISISNEVERTHAT
            case 1:
                selectedBrand = .ROMANTIC_CROWN
            case 2:
                selectedBrand = selected ? .IST_KUNST : .MINAV
            case 3:
                selectedBrand = selected ? .LIBERTENG : .LAFUDGESTORE
            case 4:
                selectedBrand = selected ? .COVERNAT : .MORE_OR_LESS
            case 5:
                selectedBrand = .ANDERSSON
            case 6:
                selectedBrand = selected ? .INSILENCE : .OiOi
            case 7:
                selectedBrand = .CRITIC
            default: break
        }
        
        if append{
            brandIdx.append(selectedBrand.rawValue)
            
            if brandIdx.count == 2 {
                nextBtn.setImage( #imageLiteral(resourceName: "icPurplearrow"), for: .normal)
            }
        }
        else {
            if let index = brandIdx.index(of: selectedBrand.rawValue) {
                brandIdx.remove(at: index)
                nextBtn.setImage(#imageLiteral(resourceName: "icGrayarrow"), for: .normal)
            }
            
            
        
        }
        
    }
    
}




