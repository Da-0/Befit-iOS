//
//  CategoryDetailVC.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class CategoryDetailVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backBtn: UIBarButtonItem!

    var productList:[Product]? = []
    
    var categoryName: String?
    var categoryIdx: Int = 0
    var genderIdx: Int = 0
    var genderTxt: String = ""
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.topItem?.title = categoryName
        self.backBtn.image = #imageLiteral(resourceName: "backArrow")
        
        if genderIdx == 0 {genderTxt = "w"}
        else { genderTxt = "m"}
        
        initCategoryProductList1()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
}



extension CategoryDetailVC: UICollectionViewDataSource{
    
    
    //MARK: - Reusable view cell (Header)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategorySortingCVCell", for: indexPath as IndexPath) as! CategorySortingCVCell
            
            cell.NewBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
            cell.PopularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
            
            return cell
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    @objc func newBtnClicked(){
        initCategoryProductList1()
        
    }
    
    @objc func popularBtnClicked(){
        initCategoryProductList2()
        
    }
    
    func initCategoryProductList1(){
        BrandProductSorting.shared.showSortingNewCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
            self.productList = product
            self.collectionView.reloadData()
        }
    }
    
    func initCategoryProductList2(){
        BrandProductSorting.shared.showSortingPopularCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
            self.productList = product
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: - content view cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = productList else {return 0}
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
     
        cell.productImg.imageFromUrl(productList?[indexPath.row].image_url, defaultImgPath: "")
        cell.brandName.text = productList?[indexPath.row].name_korean
        cell.productName.text = productList?[indexPath.row].name
        cell.price.text = productList?[indexPath.row].price
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row
        
        
        if productList?[indexPath.row].product_like == 1 {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        }else{
            cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)
        }

        return cell
    }

    @objc func clickLike(_ sender: UIButton){

        guard let productIdx = productList?[sender.tag].idx else {return}
        
         //1) 브랜드 좋아요 취소가 작동하는 부분
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
            
        //2)브랜드 좋아요가 작동하는 부분
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
    
    //MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryProduct = productList?[indexPath.row]
        
        let productVC  = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        
        guard let link = categoryProduct?.link else {return}
        guard let brandName = categoryProduct?.name_English else {return}
        
        productVC.address = link
        productVC.brandName = brandName
        productVC.productInfo = categoryProduct
        
        self.present(productVC, animated: true, completion: nil)

    }
    
    
}


extension CategoryDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 239
        let width = 167
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    
}
