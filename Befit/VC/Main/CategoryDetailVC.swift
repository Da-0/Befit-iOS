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
    var categoryIdx: Int?
    var genderIdx: Int?
    var genderTxt: String?
    
    //prevent Button image disappear in custom cell
    var productLikesImg: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVC()
        sortingNew(idx: categoryIdx!, gneder: genderTxt!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initVC(){
        self.backBtn.image = #imageLiteral(resourceName: "backArrow")
        navigationBar.topItem?.title = categoryName
        genderTxt = genderIdx == 0 ? "w" : "m"
       
    }

    @objc func newBtnClicked(){
        sortingNew(idx: categoryIdx!, gneder: genderTxt!)
        
    }
    
    @objc func popularBtnClicked(){
        sortingPopular(idx: categoryIdx!, gender: genderTxt!)
        
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
    
    //MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryProduct = productList?[indexPath.row]
        let productVC  = Storyboard.shared().product.instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        productVC.productInfo = categoryProduct
        self.present(productVC, animated: true, completion: nil)
        
    }
    
    
    //MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVCell", for: indexPath) as! ProductCVCell
        guard let product = productList?[indexPath.row] else {return cell}
        
        cell.productImg.imageFromUrl(product.image_url, defaultImgPath: "")
        cell.brandName.text = product.name_korean
        cell.productName.text = product.name
        cell.price.text = product.price
     
        //likeBtn 구현부
        cell.likeBtn.addTarget(self, action: #selector(clickLike(_:)), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.setImage(productLikesImg?[indexPath.row] , for: .normal)
        
        return cell
    }

    //MARK: - 좋아요 클릭 기능
    @objc func clickLike(_ sender: UIButton){

        guard let productIdx = productList?[sender.tag].idx else {return}
        
         //1) 상품 좋아요 취소가 작동하는 부분
        if sender.imageView?.image == #imageLiteral(resourceName: "icLikeFull") {
            unlike(idx: productIdx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeLine")
            sender.setImage(#imageLiteral(resourceName: "icLikeLine"), for: .normal)
         
        }
            
        //2) 상품 좋아요가 작동하는 부분
        else {
            like(idx: productIdx)
            productLikesImg?[sender.tag] = #imageLiteral(resourceName: "icLikeFull")
            sender.setImage(#imageLiteral(resourceName: "icLikeFull"), for: .normal)
           
        }
        
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

//Mark: - Network Service
extension CategoryDetailVC {
    
    func sortingNew(idx: Int, gneder: String){
        ProductSortingService.shared.showSortingNewCategory(categoryIdx: idx, gender: gneder) { (productData) in
            self.productList = productData
            self.productLikesImg = []
            
            for product in productData {
                let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                self.productLikesImg?.append(likeImg)
            }
            self.collectionView.reloadData()
        }
    }
    
    func sortingPopular(idx: Int, gender: String){
        ProductSortingService.shared.showSortingPopularCategory(categoryIdx: idx, gender: gender) { (productData) in
            self.productList = productData
            self.productLikesImg = []
            
            for product in productData {
                let likeImg = product.product_like == 1 ? #imageLiteral(resourceName: "icLikeFull") : #imageLiteral(resourceName: "icLikeLine")
                self.productLikesImg?.append(likeImg)
            }
            self.collectionView.reloadData()
        }
    }
    
    func like(idx: Int){
        LikePService.shared.like(productIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                case 201 :
                    print("상품 좋아요 성공!")
                case 400...600 :
                    self.simpleAlert(title: "ERROR", message: res.message!)
                default: return
                }
            }
        }
    }
    
    func unlike(idx: Int){
        LikePService.shared.unlike(productIdx: idx) { (res) in
            if let status = res.status {
                switch status {
                    case 200 :
                        print("상품 좋아요 취소 성공!")
                    case 400...600 :
                        self.simpleAlert(title: "ERROR", message: res.message!)
                    default: return
                }
            }
        }
    }

}
