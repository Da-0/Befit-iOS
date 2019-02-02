//
//  ChangeBrandVC.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  2)나의 패션 취향 재선택 VC

import UIKit

class ChangeBrandVC: UIViewController {
    
    //Buttons Images
    let menUnselected: [UIImage] = [#imageLiteral(resourceName: "manThisisneverthat"),#imageLiteral(resourceName: "manRomanticcrown"),#imageLiteral(resourceName: "manIstkunst"),#imageLiteral(resourceName: "manLiberteng"),#imageLiteral(resourceName: "manCovernat"),#imageLiteral(resourceName: "manAnderssonbell"),#imageLiteral(resourceName: "manInsilence"),#imageLiteral(resourceName: "manCritic")]
    var menSelected:[UIImage] = [#imageLiteral(resourceName: "manSelectThisisneverthat"),#imageLiteral(resourceName: "manSelectRomanticcrown"),#imageLiteral(resourceName: "manSelectIstkunst"),#imageLiteral(resourceName: "manSelectLiberteng"),#imageLiteral(resourceName: "manSelectCovernat"),#imageLiteral(resourceName: "manSelectAnderssonbell"),#imageLiteral(resourceName: "manSelectInsilence"),#imageLiteral(resourceName: "manSelectCritic")]
    let womenUnselected: [UIImage] = [#imageLiteral(resourceName: "womanThisisneverthat"),#imageLiteral(resourceName: "womanRomanticCrwon"),#imageLiteral(resourceName: "womanMinav"),#imageLiteral(resourceName: "womanLafudgestore"),#imageLiteral(resourceName: "womanMoreOrLess"),#imageLiteral(resourceName: "womanAnderssonBell"),#imageLiteral(resourceName: "womanOioi"),#imageLiteral(resourceName: "womanCritic")]
    let womenSelected:[UIImage] = [#imageLiteral(resourceName: "womanSelectThisisneverthat"),#imageLiteral(resourceName: "womanSelectRomanticCrown"),#imageLiteral(resourceName: "womanSelectMinav"),#imageLiteral(resourceName: "womanSelectLafudgestore"),#imageLiteral(resourceName: "womanSelectMoreOrLess"),#imageLiteral(resourceName: "womanSelectAnderssonBell"),#imageLiteral(resourceName: "womanSelectOioi"),#imageLiteral(resourceName: "womanSelectCritic")]
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
         self.tabBarController?.tabBar.isHidden = false
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

       for Idx in brandIdx {

            switch Idx {

                case 17:
                    btnArray[0].isSelected = true; break;
                case 12:
                     btnArray[1].isSelected = true; break;
                case 2,18:
                     btnArray[2].isSelected = true; break;
                case 10,3:
                     btnArray[3].isSelected = true; break;
                case 7,32 :
                     btnArray[4].isSelected = true; break;
                case 9:
                     btnArray[5].isSelected = true; break;
                case 22,37:
                     btnArray[6].isSelected = true; break;
                case 14:
                     btnArray[7].isSelected = true; break;
                default: break

            }
        }
   
    }
    
    
    @IBAction func backAction(_ sender: Any) {
    
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
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        if brandIdx.count == 2 {
            if sender.isSelected == true {
                sender.isSelected = false
                self.appendRemoveIdx(false, sender.tag)
            }
        }
        else {
            
            if sender.isSelected == false {
                sender.isSelected = true
                self.appendRemoveIdx(true, sender.tag)

            }
            else {
                sender.isSelected = false
                self.appendRemoveIdx(false, sender.tag)
            }
            
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
            default: return
        }
        
        if append{
            brandIdx.append(selectedBrand.rawValue)
            
            if brandIdx.count == 2 {
                backBtn.isEnabled = true
            }
        }
        else {
            if let index = brandIdx.index(of: selectedBrand.rawValue) {
                brandIdx.remove(at: index)
                backBtn.isEnabled = false
            }
            
        }
        
    }


}

