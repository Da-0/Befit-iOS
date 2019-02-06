//
//  SearchVC1.swift
//  Befit
//
//  Created by 이충신 on 29/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Search.Storyboard
//  1) 불규칙적인 액자형태의 복잡한 VC

import UIKit
import SNCollectionViewLayout

class SearchVC1: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchProductList:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        initSNCollection()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        initproductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
    
    func initSNCollection() {
        let snCollectionViewLayout = SNCollectionViewLayout()
        snCollectionViewLayout.delegate = self;
        snCollectionViewLayout.fixedDivisionCount = 6
        collectionView.collectionViewLayout = snCollectionViewLayout
    }


    // refreshControl이 돌아갈 때 일어나는 액션
    @objc func reloadData(_ sender: UIRefreshControl) {
        self.initproductList()
        collectionView.reloadData()
        sender.endRefreshing()
    }
    
}


extension SearchVC1: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = searchProductList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as! SearchCVCell
        cell.productImg.imageFromUrl2(product.image_url!, defaultImgPath: "")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let searchProduct = searchProductList[indexPath.row]
        let productVC = Storyboard.shared().product.instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
    
        productVC.productInfo = searchProduct
        
        self.navigationController?.present(productVC, animated: true, completion: nil)
        
    }
}


extension SearchVC1: SNCollectionViewLayoutDelegate {
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        
        if indexPath.row == 0 || indexPath.row == 9 || indexPath.row == 16 {
            return 4
        }
        else if indexPath.row % 8 == 6 || indexPath.row % 8 == 7  {
            return 3
        }
        
        return 2
    }
    
}

//Mark: - Nerwork Service
extension SearchVC1{
    func initproductList(){
        SearchFirstService.shared.showSearchFirstView { (productData) in
            self.searchProductList = productData
            self.collectionView.reloadData()
        }
    }
}
