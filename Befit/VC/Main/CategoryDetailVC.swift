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

    var categoryProductList:[Product]? = []
    
    var categoryName: String?
    var categoryIdx: Int = 0
    var genderIdx: Int = 0
    var genderTxt: String = ""
    var productIdx: Int?
    
    // HaveTheRain : Back To CategoryVC Code Start
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBAction func backBtnAction(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    // HaveTheRain : Back To CategoryVC Code End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    
    // HaveTheRain : Modified To NavigationBar Code Start
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.topItem?.title = categoryName
        let backBtnImg = #imageLiteral(resourceName: "backArrow")
        self.backBtn.image = backBtnImg
        
        if genderIdx == 0 {
            genderTxt = "w"
        }else {
            genderTxt = "m"
        }
        
        initCategoryProductList1()
        
    }
    
    func initCategoryProductList1(){
        
        BrandProductSorting.shared.showSortingNewCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
         
            self.categoryProductList = product
            print("\n신상순 정렬")
            print(product)
        
            self.collectionView.reloadData()
        }
        
    }
    
    func initCategoryProductList2(){
        
        BrandProductSorting.shared.showSortingPopularCategory(categoryIdx: self.categoryIdx, gender: genderTxt) { (product) in
            
            self.categoryProductList = product
            print("\n인기순 정렬")
            print(product)
            
            self.collectionView.reloadData()
        }
        
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
//    @IBAction func backBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
        

}

extension CategoryDetailVC: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = categoryProductList else {return 0}
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
        
        if categoryProductList?[indexPath.row].product_like == 1 {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
        }else{
            cell.likeBtn.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)
        }
        
        cell.backgroundColor = UIColor.white
        
        cell.productImg.imageFromUrl(categoryProductList?[indexPath.row].image_url, defaultImgPath: "")
        
        cell.brandName.text = categoryProductList?[indexPath.row].name_korean
        cell.productName.text = categoryProductList?[indexPath.row].name
        cell.price.text = categoryProductList?[indexPath.row].price
        
        
        
        //브랜드 좋아요 하트 버튼 설정
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategorySortingCVCell", for: indexPath as IndexPath) as! CategorySortingCVCell
//            cell.likeProductNumbLB.text = "찜한상품 " + "\(productLikeList.count)"
            
            //인기순 신상품순 버튼 설정
            cell.NewBtn.addTarget(self, action: #selector(newBtnClicked), for: .touchUpInside)
            cell.PopularBtn.addTarget(self, action: #selector(popularBtnClicked), for: .touchUpInside)
            
            return cell
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
   
    @objc func newBtnClicked(){
        print("신상버튼")
        initCategoryProductList1()
        
    }
    
    @objc func popularBtnClicked(){
        print("인기버튼")
        initCategoryProductList2()
        
    }
    
    
    //좋아요가 작동하는 부분
    @objc func clickLike(_ sender: UIButton){
        
        print(sender.tag)
        
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull2"), for: .normal)
            
            //1) 브랜드 좋아요 취소가 작동하는 부분
            UnLikePService.shared.unlike(productIdx: productIdx!) { (res) in
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
            
        else {
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
            
            //2)브랜드 좋아요가 작동하는 부분
            LikePService.shared.like(productIdx: productIdx!) { (res) in
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("셀이 클릭되었습니다!!!!")
        print(indexPath.row)
        
        let categoryProduct = categoryProductList?[indexPath.row]
        
        let productVC  = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        
        guard let link = categoryProduct?.link else {return}
        guard let brandName = categoryProduct?.name_English else {return}
        
        productVC.address = link
        productVC.brandName = brandName
        productVC.productInfo = categoryProduct
        
        print(productVC.address)
        print(productVC.brandName)
        print(productVC.productInfo)
        
        //이 부분 수정 필요
        self.navigationController?.present(productVC, animated: true, completion: nil)
    }
    
    
}


extension CategoryDetailVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
        // let width: CGFloat = (self.collectionView.frame.width ) / 2 - 20
        // let height: CGFloat =  (self.collectionView.frame.height ) / 2 - 20
        
        return CGSize(width: 167, height: 235)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    
    
    
    
}
