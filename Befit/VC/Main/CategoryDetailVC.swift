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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        navigationBar.topItem?.title = categoryName
        
        initCategoryProductList1()
        
    }
    
    func initCategoryProductList1(){
        BrandProductSorting.shared.showSortingNewCategory(categoryIdx: self.categoryIdx, gender: "\(self.genderIdx)") { (product) in
         
            self.categoryProductList = product
            print("\n신상순 정렬")
            print(product)
        
            self.collectionView.reloadData()
        }
        
    }
    
    func initCategoryProductList2(){
        
        BrandProductSorting.shared.showSortingPopularCategory(categoryIdx: self.categoryIdx, gender: "\(self.genderIdx)") { (product) in
            
            self.categoryProductList = product
            print("\n신상순 정렬")
            print(product)
            
            self.collectionView.reloadData()
        }
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



extension CategoryDetailVC: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = categoryProductList else {return 0}
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
        
        cell.productImg.imageFromUrl(categoryProductList?[indexPath.row].image_url, defaultImgPath: "")
            
            
        cell.brandName.text = categoryProductList?[indexPath.row].brand_Korean_name
        cell.productName.text = categoryProductList?[indexPath.row].name
        cell.price.text = categoryProductList?[indexPath.row].price
        
        return cell
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
