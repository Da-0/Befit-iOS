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
    var productList: [Product]?
    
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
    
}

extension BrandVC: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {return 1}
        else {
            guard let product = productList else {return 0}
            return product.count
        }
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1) 상단부 브랜드 페이지
        if indexPath.section == 0 {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandDetailCVCell", for: indexPath) as! BrandDetailCVCell
            
            cell1.BrandLogoImg.imageFromUrl(brandInfo.logo_url, defaultImgPath: "")
            cell1.brandBackGround.imageFromUrl(brandInfo.mainpage_url, defaultImgPath: "")
            cell1.BrandNameEndglishLB.text = brandInfo.name_english
            cell1.BrandNameKoreanLB.text = brandInfo.name_korean
            
            if brandInfo.likeFlag == 1 {cell1.LikeBtn.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)}
            else{cell1.LikeBtn.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)}
            
            guard let product = productList else {return cell1}
            
            cell1.LikeBtn.addTarget(self, action: #selector(clickBLike(_:)), for: .touchUpInside)
            cell1.ProductNumLB.text = "PRODUCT (" + "\(product.count)" + ")"
            cell1.NewBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
            cell1.PopularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
          
            return cell1
        }
            
        //2) 하단부 브랜드의 상품 리스트
        else {
        
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
        
            cell2.brandName.text = productList?[indexPath.row].name_korean
            cell2.productName.text = productList?[indexPath.row].name
            cell2.price.text = productList?[indexPath.row].price
            cell2.likeBtn.addTarget(self, action: #selector(clickPLike(_:)), for: .touchUpInside)
            cell2.likeBtn.tag = indexPath.row
            cell2.productImg.imageFromUrl(productList?[indexPath.row].image_url, defaultImgPath: "")
            
            return cell2
        }
        
    }
    
    @objc func newBtnClicked(){
        productListNewInit()
        
    }
    
    @objc func popularBtnClicked(){
        productListPopularInit()
        
    }
    
    func productListNewInit() {
        BrandProductSorting.shared.showSortingNew (brandIdx: brandIdx!, completion: { (productData) in
            self.productList = productData
            self.collectionView.reloadData()
        })
    }
    
    func productListPopularInit() {
        BrandProductSorting.shared.showSortingPopular(brandIdx: brandIdx!, completion: { (productData) in
            self.productList = productData
            self.collectionView.reloadData()
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //상단부 클릭시 브랜드의 홈페이지로 이동
        if indexPath.section == 0 {
            let productVC  = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
            productVC.brandName = brandInfo.name_english
            productVC.address = brandInfo.link
            productVC.brandHome = true
            self.navigationController?.present(productVC, animated: true, completion: nil)
        }
        //하단부 클릭시 상품의 페이지몰로 이동
        else {
            let productVC  = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
            productVC.brandName = productList?[indexPath.row].name_English
            productVC.address = productList?[indexPath.row].link
            productVC.productInfo = productList?[indexPath.row]
            self.navigationController?.present(productVC, animated: true, completion: nil)
        }
        
    }
    
}



//MARK: - 좋아요 클릭 기능
extension BrandVC {
    
    //1. 브랜드 좋아요
    @objc func clickBLike(_ sender: UIButton){
        
        //1) 브랜드 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)
            UnLikeBService.shared.unlike(brandIdx: brandIdx!) { (res) in
                if let status = res.status {
                    switch status {
                    case 200 :
                        print("브랜드 좋아요 취소 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
        }
        //2) 브랜드 좋아요가 작동하는 부분
        else {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
            LikeBService.shared.like(brandIdx: brandIdx!) { (res) in
                if let status = res.status {
                    switch status {
                    case 201 :
                        print("브랜드 좋아요 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
            
        }
        
    }
    
    
    
    //2. 상품 좋아요 관련
    @objc func clickPLike(_ sender: UIButton){
        
        guard let productIdx = productList?[sender.tag].idx else {return}
        
        //1) 상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)
            
            UnLikePService.shared.unlike(productIdx: productIdx) { (res) in
                if let status = res.status {
                    switch status {
                    case 200 :
                        print("상품 좋아요 취소 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
        }
            
        //2) 상품 좋아요가 작동하는 부분
        else {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
            
            LikePService.shared.like(productIdx: productIdx) { (res) in
                if let status = res.status {
                    switch status {
                    case 201 :
                        print("상품 좋아요 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: break
                    }
                }
            }
            
        }
        
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
            return CGSize(width: 167, height: 239)
        }
        
   }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 9
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        }
        
    }
    
}



