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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;

        // if 콜렉션뷰 모델의 수 == 0 {
        
            // tabView.isHidden = false
            //편집 버튼 히든
        
        // }
    
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        navigationBar.topItem?.title = categoryName
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
    
    
    @IBAction func editBtn(_ sender: Any) {
        //Edit collectionView
        //편집이후 통신이 일어나는 시점.
        
    }
    
}

extension SizeInfoVC2 : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeInfo2CVCell", for: indexPath) as! SizeInfo2CVCell
        
        //cell.brandName.text =
        //cell.productName.text  =
        
    
        return cell
        
    }
    
    
    
    

    
    
}


