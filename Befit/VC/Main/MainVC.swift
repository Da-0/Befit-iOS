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
            self.collectionView.reloadData()
        }
        
        //2) 나를 위한 상품 추천 호출
        ProductRecService.shared.showProductRec { (res) in
            self.recommendProduct = res.data
            self.collectionView.reloadData()
        }
        
    }
    
    
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
            cell0.delegate = self;
            cell0.collectionView0.reloadData()
            return cell0
        }
            
            //2) Banner 구현부
        else if indexPath.section == 1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell1", for: indexPath) as! MainCVCell1
            
            return cell1
        }
            //3)나를 위한 추천 레이블 있는 곳(기능X) ->  변경이 필요
        else if indexPath.section == 2 {
            let cell12 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell12", for: indexPath) as! MainCVCell12
            return cell12
        }
            //4) 나를 위한 상품 추천 Cell
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell2", for: indexPath) as! MainCVCell2
            
            guard let productList = recommendProduct else {return cell2}
            cell2.productImg.imageFromUrl(productList[indexPath.row].image_url, defaultImgPath: "")
            cell2.brandName.text = productList[indexPath.row].name_English
            cell2.productName.text = productList[indexPath.row].name
            return cell2
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        // row가 아니라 session으로 변경 필요
        if indexPath.section == 0 {
            //아무것도 안일어난다 (맨위의 셀은 브랜드와 상품이동페이지가 나오기때문)
        }
            
        else if indexPath.section == 1 {
            //배너의 이동
        }
        else if indexPath.section == 2 {
            //배너의 이동
        }
        else {
            
            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            productVC.brandName = recommendProduct?[indexPath.row].name_English
            productVC.address = recommendProduct?[indexPath.row].link
            // productVC.productIdx = recommendProduct?[indexPath.row].idx
            productVC.productInfo = recommendProduct?[indexPath.row]
    
            self.navigationController?.present(productVC, animated: true, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
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

extension MainVC: customCellDelegate {
  
    
    func mainBrandPressed(cell: MainCVCell0, idx: Int) {
        
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        
            productVC.brandName = self.recommendBrand[idx].name_english
            productVC.address = self.recommendBrand[idx].link
            productVC.brandHome = true

        self.present(productVC, animated: true, completion: nil)
    }
    
    
    
    func brandProductsPressed(cell: MainCVCell0, idx: Int) {
        
        let bid = Int(idx/3)
        let pid = idx % 3
        
        print(recommendBrand[bid].products?[pid].price)
        
        //VC의 전환을 일으키면 됨 (브랜드 뷰로)
        
    }
    
    
}
