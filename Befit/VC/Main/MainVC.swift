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
   
    var bannerBrandInfo1: Brand?
    var bannerBrandInfo2: Brand?

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
        
        //3) 배너 광고에 대한 브랜드 호출
        
        BannerBrandService.shared.showBannerBrand(idx: 33) { (res) in
                guard let brandInfo = res.data else {return}
                self.bannerBrandInfo1 = brandInfo
          }
        BannerBrandService.shared.showBannerBrand(idx: 21) { (res) in
            guard let brandInfo = res.data else {return}
            self.bannerBrandInfo2 = brandInfo
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
            cell1.delegate = self;
            cell1.collectionView1.reloadData()
            return cell1
        }
            
        //3)나를 위한 추천 레이블(기능X)
        else if indexPath.section == 2{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell2", for: indexPath) as! MainCVCell2
            return cell2
        }
            
        //4) 나를 위한 상품 추천 Cell
        else  {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell3", for: indexPath) as! MainCVCell3
            
            guard let productList = recommendProduct else {return cell3}
            cell3.productImg.imageFromUrl(productList[indexPath.row].image_url, defaultImgPath: "")
            cell3.brandName.text = productList[indexPath.row].name_English
            cell3.productName.text = productList[indexPath.row].name
            return cell3
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == 0 {}
        else if indexPath.section == 1 {}
        else if indexPath.section == 2 {}
            
        else {
            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            productVC.brandName = recommendProduct?[indexPath.row].name_English
            productVC.address = recommendProduct?[indexPath.row].link
            productVC.productInfo = recommendProduct?[indexPath.row]
            // productVC.productIdx = recommendProduct?[indexPath.row].idx
            self.navigationController?.present(productVC, animated: true, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 375, height: 550)  // 525에서 변경
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


 //1) 브랜드 메인 + 3개 상품에 대한 Delegate
extension MainVC: customCellDelegate {
  
    //맨 위 브랜드 사진 클릭
    func mainBrandPressed(cell: MainCVCell0, idx: Int) {
        
        let brandVC = UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
            brandVC.brandInfo = recommendBrand[idx]
            brandVC.brandIdx = recommendBrand[idx].idx

        self.navigationController?.pushViewController(brandVC, animated: true)
    }
    
    //브랜드에 대한 상품 3개 클릭
    func brandProductsPressed(cell: MainCVCell0, idx: Int) {
        
        let bid = Int(idx/3)
        let pid = idx % 3

        let brandVC = UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
        brandVC.brandInfo = recommendBrand[bid]
        brandVC.productInfo = recommendBrand[bid].products?[pid]
        brandVC.brandIdx = recommendBrand[bid].idx
        
        self.navigationController?.pushViewController(brandVC, animated: true)
        
    }
    
    
}


//2) 배너에 대한 Delegate
extension MainVC: customCellDelegate2 {
    
    
    func bannerPressed(cell: MainCVCell1, idx: Int) {
        switch idx {
            case 0:
                let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
                productVC.brandName = "FRIZMWORKS"
                productVC.address = "m.frizm.co.kr/product/detail.html?product_no=1480&cate_no=33&display_group=1"
                self.present(productVC, animated: true, completion: nil)
                break
            case 1:
                let brandVC = UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
                brandVC.brandIdx = 33
                brandVC.brandInfo = bannerBrandInfo1
                
                self.navigationController?.pushViewController(brandVC, animated: true)
                break
            case 2:
                let brandVC = UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
                brandVC.brandIdx = 21
                brandVC.brandInfo = bannerBrandInfo2
                
                self.navigationController?.pushViewController(brandVC, animated: true)
                break
            default:
                break
        }

        
        
        
    }
    
    
    
}
