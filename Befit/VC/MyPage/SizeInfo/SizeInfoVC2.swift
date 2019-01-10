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
    @IBOutlet weak var tabView: UIControl!
    
    var categoryIdx: Int?
    var categoryName: String?
    var ClosetList: [Closet]?

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
        
        network()
        collectionView.reloadData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func network(){
        
        GetClosetListService.shared.showClosetList(idx: categoryIdx!, completion:{ (clsoetList) in
            
            print("현재 카테고리의 인덱스")
            print(Idx.self)
            
            self.ClosetList = clsoetList
            self.collectionView.reloadData()
            
            self.tabView.isHidden = self.ClosetList == nil ?  false : true
            self.collectionView.isHidden = self.ClosetList == nil ? true : false
        })
        
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
        
        guard let closet = ClosetList else {return 1}

        if ClosetList == nil {
            return 1
        }
        else{
            return (ClosetList?.count)! + 1
        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeInfo2CVCell", for: indexPath) as! SizeInfo2CVCell
        guard let closet = ClosetList else {return cell}
        
        cell.delegate = self;
        
        if indexPath.row == closet.count{
            cell.productImg.image = #imageLiteral(resourceName: "plusBox")
            cell.brandName.text = nil
            cell.productName.text = nil
        }
            
        else{
            cell.productImg.imageFromUrl(closet[indexPath.row].image_url!, defaultImgPath: "")
            cell.brandName.text = closet[indexPath.row].name_korean
            cell.productName.text = closet[indexPath.row].name
        }

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let closet = ClosetList else {return}
        
        if indexPath.row == closet.count{
            //마지막 index는 등록뷰로 이동
            let sizeInfoVC3 = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
            self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
            
        }
        else {
            //내 사이즈 확인뷰로 이동
            let mysizeVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MySizeVC")as! MySizeVC
            mysizeVC.categoryIdx = self.categoryIdx
             UserDefaults.standard.set(closet[indexPath.row].closet_idx!, forKey: "closet_idx")
            self.navigationController?.pushViewController(mysizeVC, animated: true)
            
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
            
            guard let closet = ClosetList else {return}
            //closet.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])

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
