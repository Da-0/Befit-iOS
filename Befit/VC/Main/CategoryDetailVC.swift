//
//  CategoryDetailVC.swift
//  Befit
//
//  Created by 이충신 on 05/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class CategoryDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var categoryName: String?
    
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
        let backBtnImg = UIImage(named: "backArrow")
        self.backBtn.image = backBtnImg
    }
    // HaveTheRain : Modified To NavigationBar Code End
}



extension CategoryDetailVC: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCVCell", for: indexPath) as! CategoryDetailCVCell
        
        cell.productImg.image = #imageLiteral(resourceName: "testImage")
        cell.brandName.text = "헬로월드"
        cell.productName.text = "옷옷옷"
        cell.price.text = "150,000"
        
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
