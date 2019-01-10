//
//  BrandVC.swift
//  Befit
//
//  Created by 박다영 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class BrandVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    func popularReload(){
        //인기순을 클릭했을때 통신이 일어나는 시점
        
    }
    
    
    @objc
    func newReload(){
        //신상품순을 클릭했을때 통신이 일어나는 시점
        
    }
}

extension BrandVC: UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandDetailCVCell", for: indexPath) as! BrandDetailCVCell
            
            cell1.BrandLogoImg.setRounded()
            cell1.brandBackGround.image = #imageLiteral(resourceName: "brandBackground")
            cell1.BrandNameEndglishLB.text = "VANS"
            cell1.BrandNameKoreanLB.text = "반스"
            
            cell1.ProductNumLB.text = "PRODUCT" + " ()"
            cell1.PopularBtn.setTitle("인기순", for: .normal)
            cell1.NewBtn.setTitle("신상품순", for: .normal)
            
            return cell1
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
            
            
            cell2.productImg.image = #imageLiteral(resourceName: "testImage")
            cell2.brandName.text = "헬로월드"
            cell2.productName.text = "옷옷옷"
            cell2.price.text = "150,000"
            
            return cell2
        }
        
    }
    
}


extension BrandVC: UICollectionViewDelegateFlowLayout{
    
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BrandCRV", for: indexPath as IndexPath) as! BrandCRV
            
            cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            cell.isUserInteractionEnabled = true;
            
            cell.popularBtn.addTarget(self, action: #selector(popularReload), for: .touchUpInside)
            cell.newBtn.addTarget(self, action: #selector(newReload), for: .touchUpInside)
            cell.productAmount.text = "PRODUCT" + " ()"
            
            return cell
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
     */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 375, height: 268)
        }
        else {
            //iphone사이즈에 따라 동적으로 대응이 가능해진다.
            // let width: CGFloat = (self.collectionView.frame.width ) / 2 - 20
            // let height: CGFloat =  (self.collectionView.frame.height ) / 2 - 20
            return CGSize(width: 167, height: 235)
        }
        
   }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 9
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        }
        
    }
    
}


extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
