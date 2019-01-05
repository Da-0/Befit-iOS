//
//  SizeInfoVC2.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

// 콜렉션뷰에서 의류를 선택하는 뷰

import UIKit

class SizeInfoVC2: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var categoryName: String?

    @IBOutlet weak var tabView: UIControl!
    var Model: [SizeItems]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        navigationBar.topItem?.rightBarButtonItem = editButtonItem
        editButtonItem.tintColor = .black

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        navigationBar.topItem?.title = categoryName
       
        ///**************통신이 일어나는 시점 **************
        Model = [
            SizeItems(image: #imageLiteral(resourceName: "testImage"), brand: "헬로월드", product: "나이키"),
            SizeItems(image: #imageLiteral(resourceName: "testImage"), brand: "헬로월드", product: "나이키"),
            SizeItems(image: #imageLiteral(resourceName: "testImage"), brand: "헬로월드", product: "나이키")
        ]
        
        tabView.isHidden = Model.count != 0 ?  true : false
        collectionView.isHidden = Model.count != 0 ? false: true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }

    @IBAction func tabViewAction(_ sender: Any) {
        
        let sizeInfoVC3 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
        self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension SizeInfoVC2 : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return Model.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeInfo2CVCell", for: indexPath) as! SizeInfo2CVCell
        
        cell.delegate = self;
        
        if indexPath.row == Model.count{
            cell.productImg.image = #imageLiteral(resourceName: "plusBox")
            cell.brandName.text = nil
            cell.productName.text = nil
        }
            
        else{
            cell.productImg.image = Model[indexPath.row].image
            cell.brandName.text = Model[indexPath.row].brandName
            cell.productName.text = Model[indexPath.row].productName
        }

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == Model.count {
            //마지막 index는 등록뷰로 이동
            let sizeInfoVC3 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
            self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
            
        }
        else {
            
            //내 사이즈 확인뷰로 이동
            
        }
    
    }
    
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)

        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            
            for indexPath in indexPaths {
                
                if let cell = collectionView?.cellForItem(at: indexPath) as? SizeInfo2CVCell {
                    cell.isEditing = editing
                    
                    //if indexPath.row == Model.count {
                    if cell.productImg.image == #imageLiteral(resourceName: "plusBox"){
                        cell.isEditing = false
                        cell.isUserInteractionEnabled = !editing
                    }
                    
                }
            }
        }
    }

}




extension SizeInfoVC2: SizeInfo2CellDelegate {
    
    func delete(cell: SizeInfo2CVCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            
            Model.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            
            print(Model.count)
        }
    }
}




extension SizeInfoVC2: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 186, height: 279)
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
