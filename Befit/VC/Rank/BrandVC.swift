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
    var brandInfo : Brand!
    var brandIdx: Int?
    var productInfo: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        productListNewInit()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func productListNewInit() {
        BrandProductSorting.shared.showSortingNew (brandIdx: brandIdx!, completion: { (productData) in
            self.productInfo = productData
            print("\n신상순 정렬")
            print(productData)
            self.collectionView.reloadData()
        })
    }
    
    func productListPopularInit() {
        BrandProductSorting.shared.showSortingPopular(brandIdx: brandIdx!, completion: { (productData) in
            self.productInfo = productData
            print("\n인기순 정렬")
            print(productData)
            self.collectionView.reloadData()
        })
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
            guard let product = productInfo else {return 0}
            return product.count
        }
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandDetailCVCell", for: indexPath) as! BrandDetailCVCell
            
            cell1.BrandLogoImg.setRounded()
            cell1.BrandLogoImg.imageFromUrl(brandInfo.logo_url, defaultImgPath: "")
            cell1.brandBackGround.imageFromUrl(brandInfo.mainpage_url, defaultImgPath: "")
            
            cell1.BrandNameEndglishLB.text = brandInfo.name_english
            cell1.BrandNameKoreanLB.text = brandInfo.name_korean
            guard let product = productInfo else {return cell1}
            cell1.ProductNumLB.text = "PRODUCT (" + "\(product.count)" + ")"
            
            cell1.NewBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
            cell1.PopularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
            
            return cell1
        }
        else {
            
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
            
            cell2.backgroundColor = UIColor.white
            
            cell2.brandName.text = productInfo?[indexPath.row].brand_Korean_name
            cell2.productName.text = productInfo?[indexPath.row].name
            cell2.price.text = productInfo?[indexPath.row].price
            cell2.productImg.imageFromUrl(productInfo?[indexPath.row].image_url, defaultImgPath: "")
            
            return cell2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productVC  = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        productVC.brandName = productInfo?[indexPath.row].brand_English_name
        productVC.address = productInfo?[indexPath.row].link
        self.navigationController?.present(productVC, animated: true, completion: nil)
    }
    
    
    @objc func newBtnClicked(){
        print("신상버튼")
        productListNewInit()
        
    }
    
    @objc func popularBtnClicked(){
        print("인기버튼")
        productListPopularInit()
        
    }
    
}


extension BrandVC: UICollectionViewDelegateFlowLayout{

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            // main에서 추천 brand 타고 들어 왔을 때 : 475
            // ranking : 268
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

