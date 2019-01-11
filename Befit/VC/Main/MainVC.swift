//
//  ViewController.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import SideMenuSwift

class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recommendBrand: [Brand] = []
    var recommendProduct: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
        self.collectionView.reloadData()
    }
    
    func network(){
        
        //1) 브랜드 추천 호출
        BrandRecService.shared.showBrandRec { (res) in
            guard let brandList = res.data else {return}
            self.recommendBrand = brandList
            print("\(brandList)")
            self.collectionView.reloadData()
        }
        
        //2) 나를 위한 상품 추천 호출
        ProductRecService.shared.showProductRec { (res) in
            self.recommendProduct = res.data
            self.collectionView.reloadData()
        }
        
    }
    
    //사이드 메뉴의 나타남
    @IBAction func categoryAction(_ sender: Any) {
        self.sideMenuController?.revealMenu();
    }
    
}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }else {
            guard let product = recommendProduct else {return 0}
            return product.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1) 최상단 브랜드 이미지 구현부
        if indexPath.section == 0
        {
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell0", for: indexPath) as! MainCVCell0
            cell0.brandInfo = recommendBrand
            cell0.collectionView0.reloadData()
            return cell0
        }
            
            //2) Banner 구현부
        else if indexPath.section == 1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell1", for: indexPath) as! MainCVCell1
            return cell1
        }
            //3
        else if indexPath.section == 2 {
            let cell12 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell12", for: indexPath) as! MainCVCell12
            return cell12
        }
            //4) 나를 위한 상품 추천 Cell
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell2", for: indexPath) as! MainCVCell2
            
            guard let productList = recommendProduct else {return cell2}
            cell2.productImg.imageFromUrl(productList[indexPath.row].image_url, defaultImgPath: "")
            cell2.brandName.text = productList[indexPath.row].brand_English_name
            cell2.productName.text = productList[indexPath.row].name
            return cell2
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // row가 아니라 session으로 변경 필요
        if indexPath.row == 1 {
            //아무것도 안일어난다 (맨위의 셀은 브랜드와 상품이동페이지가 나오기때문)
        }
            
        else if indexPath.row == 2 {
            //배너의 이동
        }
        else if indexPath.row == 3 {
            //배너의 이동
        }
        else {
            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            productVC.brandName = recommendProduct?[indexPath.row].brand_English_name
            productVC.address = recommendProduct?[indexPath.row].link
            productVC.productIdx = recommendProduct?[indexPath.row].idx
            self.navigationController?.present(productVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
        // let width: CGFloat = (self.collectionView.frame.width) / 2 - 20
        // let height: CGFloat =  (self.collectionView.frame.height) / 2 - 20
        
        if indexPath.section == 0 {
            return CGSize(width: 375, height: 525)
        }
        else if indexPath.section == 1 {
            return CGSize(width: 375, height: 90)
        }
        else if indexPath.section == 2 {
            return CGSize(width: 375, height: 70)
        }
        else {
            return CGSize(width: 186, height: 256)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
