//
//  SizeInfoVC2.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  3-2) 해당 카테고리의 내 옷장 리스트 VC (CollectionView)

import UIKit
import QuartzCore

class SizeInfoVC2: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tabView: UIControl!
    
    var categoryIdx: Int!
    var categoryName: String?
    var ClosetList: [Closet]?
    var removeClosetIdx: [Int] = []
    
    var enrollNewCloset = false

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

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func network(){
        
        GetClosetListService.shared.showClosetList(idx: categoryIdx, completion:{ (res) in
            
            self.ClosetList = res.data
            self.tabView.isHidden = self.ClosetList == nil ?  false : true
            self.collectionView.isHidden = self.ClosetList == nil ?  true : false
            self.collectionView.reloadData()
            
        })
        
    }

    @IBAction func tabViewAction(_ sender: Any) {
        
        let sizeInfoVC3 = Storyboard.shared().myPage.instantiateViewController(withIdentifier: "SizeInfoVC3")as! SizeInfoVC3
            sizeInfoVC3.categoryIdx = self.categoryIdx
    
        if enrollNewCloset == true {
            sizeInfoVC3.enrollNewCloset = true
            self.present(sizeInfoVC3, animated: true, completion: nil)
            
        }
        else {
            self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        if enrollNewCloset == true { self.dismiss(animated: true, completion: nil) }
        else { self.navigationController?.popViewController(animated: true)}
        
    }
    
    
}

extension SizeInfoVC2 : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let closet = ClosetList else {return 1}
        return closet.count + 1
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeInfo2CVCell", for: indexPath) as! SizeInfo2CVCell
         let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeInfo2TabCVCell", for: indexPath) as! SizeInfo2TabCVCell
        guard let closet = ClosetList else {return cell1}
        
        if indexPath.row == closet.count{
            cell2.tabImg.image = #imageLiteral(resourceName: "plusBox")
            return cell2
        }
        else {
            cell1.delegate = self;
            cell1.productImg.imageFromUrl(closet[indexPath.row].image_url!, defaultImgPath: "")
            cell1.brandName.text = closet[indexPath.row].name_korean
            cell1.productName.text = closet[indexPath.row].name

            return cell1
        }
      
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let closet = ClosetList else {return}
        
        if indexPath.row == closet.count{
            
            //마지막 index는 등록뷰로 이동
            let sizeInfoVC3 = Storyboard.shared().myPage.instantiateViewController(withIdentifier: "SizeInfoVC3" )as! SizeInfoVC3
            sizeInfoVC3.categoryIdx = self.categoryIdx
    
             if enrollNewCloset == true {
                sizeInfoVC3.enrollNewCloset = true
                self.present(sizeInfoVC3, animated: true, completion: nil)
             }
             else{
                self.navigationController?.pushViewController(sizeInfoVC3, animated: true)
            }
            
        }
        else {
            
            //내 사이즈 확인뷰로 이동
            let mysizeVC = Storyboard.shared().myPage.instantiateViewController(withIdentifier: "MySizeVC") as! MySizeVC
            mysizeVC.closetIdx = self.ClosetList?[indexPath.row].closet_idx
          
             if enrollNewCloset == true {
                mysizeVC.enrollNewCloset = true
                self.present(mysizeVC, animated: true, completion: nil)
             }
             else{
                self.navigationController?.pushViewController(mysizeVC, animated: true)
            }
            
        }
    
    }
    
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        if editing == false {
            RemoveClosetService.shared.removeCloset(closetIdx: removeClosetIdx) { (res) in
                if let status = res.status {
                    switch status {
                        case 200:
                         //self.simpleAlert(title: "Success", message: res.message!)
                        print(res.message!)
                        default: return
                    }
                }
            }
        }
        
        super.setEditing(editing, animated: animated)
    
    
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            
            for indexPath in indexPaths {
                
                if let cell1 = collectionView?.cellForItem(at: indexPath) as? SizeInfo2CVCell {
                    cell1.isEditing = editing
                }
            
            }
        }
    }

}




extension SizeInfoVC2: SizeInfo2CellDelegate {
    
    func delete(cell: SizeInfo2CVCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            removeClosetIdx.append(ClosetList?[indexPath.row].closet_idx ?? 0)
            print(removeClosetIdx)
            ClosetList?.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])

        }
    }
}




extension SizeInfoVC2: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 280)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 187, height: 280)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
}


