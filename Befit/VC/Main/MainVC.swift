//
//  ViewController.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import SideMenuSwift

class MainVC: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var recommendBrand: [Brand] = []
    var recommendProduct: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
        
    }
    
    func network(){
        
        //1) 브랜드 추천 호출
    
        //2) 나를 위한 상품 추천 호출
        
        
        
    }
    

    //사이드 메뉴의 나타남
    @IBAction func categoryAction(_ sender: Any) {
        self.sideMenuController?.revealMenu();
    }


}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0
        {
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell0", for: indexPath) as! MainCVCell0
                return cell0
        }
        else if indexPath.row == 1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell1", for: indexPath) as! MainCVCell1
    
            return cell1
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell2", for: indexPath) as! MainCVCell2
            return cell2
        }
        
    }


        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            //iphone사이즈에 따라 동적으로 대응이 가능해진다.
            // let width: CGFloat = (self.collectionView.frame.width) / 2 - 20
            // let height: CGFloat =  (self.collectionView.frame.height) / 2 - 20
            
            if indexPath.row == 0 {
                    return CGSize(width: 375, height: 550)
            }
            else if indexPath.row == 1 {
                   return CGSize(width: 375, height: 158)
            }
            else {
                   return CGSize(width: 186, height: 256)
            }
    
            
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

