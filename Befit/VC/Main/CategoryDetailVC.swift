//
//  CategoryDetailVC.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  Main.Storyboard
//  3) 해당 카테고리의 상품을 보여주는 VC (CollectionView)

import UIKit

class CategoryDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backBtn: UIBarButtonItem!

    var productList:[Product]? = []
    
    var categoryName: String?
    var categoryIdx: Int = 0
    var genderIdx: Int = 0
    var genderTxt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.topItem?.title = categoryName
        self.backBtn.image = #imageLiteral(resourceName: "backArrow")
        genderTxt = genderIdx == 0 ? "w" : "m"
    
        initCategoryProductList1()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    

    @objc func newBtnClicked(){
        initCategoryProductList1()
        
    }
    
    @objc func popularBtnClicked(){
        initCategoryProductList2()
        
    }
    
    func initCategoryProductList1(){
        ProductSortingService.shared.showSortingNewCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
            self.productList = product
            self.collectionView.reloadData()
        }
    }
    func initCategoryProductList2(){
        ProductSortingService.shared.showSortingPopularCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
            self.productList = product
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }

}



extension CategoryDetailVC: UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = productList else {return 0}
        return product.count
    }
    
    //MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVCell", for: indexPath) as! ProductCVCell
        guard let product = productList?[indexPath.row] else {return cell}
        
        cell.productImg.imageFromUrl(product.image_url, defaultImgPath: "")
        cell.brandName.text = product.name_korean
        cell.productName.text = product.name
        cell.price.text = product.price
        
        let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
        cell.likeBtn.setImage(likeImg , for: .normal)
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row
        
        return cell
    }

    @objc func clickLike(_ sender: UIButton){

        guard let productIdx = productList?[sender.tag].idx else {return}
        
         //1) 상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
        
           LikePService.shared.unlike(productIdx: productIdx) { (res) in
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
            
        //2)상품 좋아요가 작동하는 부분
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
            productVC.productInfo = categoryProduct
        self.present(productVC, animated: true, completion: nil)

    }
    
    
}


extension CategoryDetailVC: UICollectionViewDelegateFlowLayout {
    
    //MARK: - Reusable view cell (Header)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewPopularSortingCRV", for: indexPath as IndexPath) as! NewPopularSortingCRV
            
            cell.newBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
            cell.popularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
            
            return cell
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
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
