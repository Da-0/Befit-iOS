//
//  BrandVC.swift
//  Befit
//
//  Created by 이충신 on 17/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  Brand.Storyboard
//  1) 브랜드 페이지 VC

import UIKit

class BrandVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var brandInfo : Brand?
    var productInfo: Product?
    var productList: [Product]?
    
    //prevent Button image disappear in custom cell
    var brandLikeImg: UIImage?
    var bProductLikeImg: UIImage?
    var productLikesImg: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        brandInfoInit()
        productListNewInit()
        print("선택한 브랜드의 IDX = \(brandInfo?.idx! ?? 0)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func bactAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }

}


extension BrandVC: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {return 1}
        else if section == 1 {return 1}
        else {
            guard let product = productList else {return 0}
            return product.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productVC  = Storyboard.shared().product.instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        
        //상단부 클릭시 브랜드의 홈페이지로(웹) 이동
        if indexPath.section == 0 {
            productVC.brandInfo = brandInfo
        }
            
        //중간부 클릭시 브랜드의 자체 페이지로 이동
        else if indexPath.section == 1 {
            productVC.productInfo = productInfo
        }
            
        //하단부 클릭시 상품의 페이지몰로 이동
        else {
            guard let product = productList?[indexPath.row] else {return}
            productVC.productInfo = product
        }
        
        self.navigationController?.present(productVC, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //1) 상단부: 브랜드 정보
        if indexPath.section == 0 {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCVCell1", for: indexPath) as! BrandCVCell1
            
            cell1.brandLogoImg.imageFromUrl(brandInfo?.logo_url, defaultImgPath: "")
            cell1.brandBackGround.imageFromUrl(brandInfo?.mainpage_url, defaultImgPath: "")
            cell1.brandNameEnglishLB.text = brandInfo?.name_english
            cell1.brandNameKoreanLB.text = brandInfo?.name_korean
            
            cell1.brandLikeBtn.addTarget(self, action: #selector(clickBLike(_:)), for: .touchUpInside)
            
            cell1.brandLikeBtn.setImage(brandLikeImg, for: .normal)
            
            return cell1
            
        }
            
        //2) 중간부: 메인에서 들어올때만 나타나는 선택한 상품
        else if indexPath.section == 1 {
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCVCell2", for: indexPath) as! BrandCVCell2
            
            //브랜드의 선택한 상품
            if let pInfo = productInfo  {
                cell2.productImg.imageFromUrl2(pInfo.image_url, defaultImgPath: "")
                cell2.productBrand.text = brandInfo?.name_korean
                cell2.productName.text = pInfo.name
                cell2.price.text = pInfo.price
                
                cell2.brandProductLikeBtn.addTarget(self, action: #selector(clickBPLike(_:)), for: .touchUpInside)
                cell2.brandProductLikeBtn.setImage(bProductLikeImg, for: .normal)
              
            }
            
            //상품갯수 및 버튼
            if let pList = productList {
                cell2.productNumLB.text = "PRODUCT (" + "\(pList.count)" + ")"
                cell2.newBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
                cell2.popularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
            }
            
            return cell2
            
        }
            
        //3) 하단부: 브랜드의 상품리스트
        else {
            
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVCell", for: indexPath) as! ProductCVCell
            
            cell3.brandName.text = productList?[indexPath.row].name_korean
            cell3.productName.text = productList?[indexPath.row].name
            cell3.price.text = productList?[indexPath.row].price
            cell3.productImg.imageFromUrl2(productList?[indexPath.row].image_url, defaultImgPath: "")
            
            //likeBtn 구현부
            cell3.likeBtn.addTarget(self, action: #selector(clickPLike(_:)), for: .touchUpInside)
            cell3.likeBtn.tag = indexPath.row
            cell3.likeBtn.setImage(productLikesImg?[indexPath.row], for: .normal)
            
            return cell3
        }
        
    }
    
    
    @objc func newBtnClicked(){
        productListNewInit()
        
    }
    
    @objc func popularBtnClicked(){
        productListPopularInit()
        
    }
    
    func brandInfoInit(){
        
        //이 부분을 수정해야함 **********************************
        if let brand = brandInfo {
            print(brand)
            if brand.brandLike != nil {brandLikeImg = brand.brandLike == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")}
            if brand.likeFlag != nil {brandLikeImg = brand.likeFlag == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")}
        }
        
        if let bProduct = productInfo{
            bProductLikeImg = bProduct.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
    
        }
        
        self.collectionView.reloadData()
       
    }
    
    
}





//MARK: - 좋아요 클릭 기능
extension BrandVC {
    
    //1) 상단부: 브랜드 좋아요
    @objc func clickBLike(_ sender: UIButton){
        
        guard let idx = brandInfo?.idx else {return}
        
        //1) 브랜드 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlikeB(idx: idx)
            brandLikeImg = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
        
        }
            
        //2) 브랜드 좋아요가 작동하는 부분
        else {
            likeB(idx: idx)
            brandLikeImg = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
          
        }
        
    }
    
    //2) 중간부: 브랜드의 선택된 상품 좋아요
    @objc func clickBPLike(_ sender: UIButton){
        
        guard let idx = productInfo?.idx else {return}
        
        //1) 상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlikeP(idx: idx)
            bProductLikeImg = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
          
        }
            
            //2) 상품 좋아요가 작동하는 부분
        else {
            likeP(idx: idx)
            bProductLikeImg = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
         
        }
        
    }
    
    //3) 하단부: 상품 좋아요
    @objc func clickPLike(_ sender: UIButton){
        
        guard let idx = productList?[sender.tag].idx else {return}
       
        //1) 상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlikeP(idx: idx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
        }
            
        //2) 상품 좋아요가 작동하는 부분
        else {
            likeP(idx: idx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        }
        
    }

}


extension BrandVC: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 375, height: 228)
        }
        else if indexPath.section == 1{
            if productInfo == nil {return  CGSize(width: 375, height: 40)}
            else {return CGSize(width: 375, height: 247)}
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




//Mark: - Network Service
extension BrandVC {
    
    func productListNewInit() {
        ProductSortingService.shared.showSortingNew (brandIdx: (brandInfo?.idx)!, completion: { (productData) in
            self.productList = productData
            self.productLikesImg = []
            for product in productData {
                let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                self.productLikesImg?.append(likeImg)
            }
            self.collectionView.reloadData()
        })
    }
    
    func productListPopularInit() {
        ProductSortingService.shared.showSortingPopular(brandIdx: (brandInfo?.idx)!, completion: { (productData) in
            self.productList = productData
            self.productLikesImg = []
            for product in productData {
                let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                self.productLikesImg?.append(likeImg)
            }
            self.collectionView.reloadData()
        })
    }
    
    func likeP(idx: Int){
        
        LikePService.shared.like(productIdx: idx) { (res) in
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
    
    func unlikeP(idx: Int){
        LikePService.shared.unlike(productIdx: idx) { (res) in
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
    
    func likeB(idx: Int){
        
        LikeBService.shared.like(brandIdx: idx) { (res) in
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
    
    
    func unlikeB(idx: Int){
        
        LikeBService.shared.unlike(brandIdx: idx) { (res) in
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
    
    
    
    
    
    
    
}
