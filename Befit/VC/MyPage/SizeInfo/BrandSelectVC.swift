//
//  BrandSelectVC.swift
//  Befit
//
//  Created by 이충신 on 03/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MyPage.Storyboard
//  3-4) Alphabet으로 브랜드 선택을 하는 VC (CollectionView + TableView)

import UIKit

protocol BrandVCDelegate
{
    func BrandVCResponse(value: Brand)
}

class BrandSelectVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    var delegate: BrandVCDelegate?
    var enrollNewCloset = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ETC"]
    
    var selectedAlphabet: String?
    var selectedButton: String?
    
    @IBOutlet weak var tableView: UITableView!
    var brand: [Brand]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()

    }
    
    @IBAction func backBtn(_ sender: Any) {
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
}


extension BrandSelectVC : UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if brand == nil {
            return 0
        }else {
            return brand!.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandSelectTVCell", for: indexPath) as! BrandSelectTVCell
        guard let _brand = brand else {return cell}
        
        cell.brandName.text = _brand[indexPath.row].name_english
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let _brand = brand else {return}
        self.delegate?.BrandVCResponse(value: _brand[indexPath.row])
        //userDefault.set(_brand[indexPath.row].idx!, forKey: "brand_idx")
        if enrollNewCloset == true {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
      
    }

}


//collectionView
extension BrandSelectVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlphabetCVCell", for: indexPath) as! AlphabetCVCell
        cell.alphabet.text = alphabet[indexPath.item]
        cell.alphabet.adjustsFontSizeToFitWidth = true
        cell.alphabet.minimumScaleFactor = 0.2
        return cell
    }
}

extension BrandSelectVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! AlphabetCVCell
        
        if cell.isSelected {
            cell.isSelected = false
        }else {
            cell.isSelected = true
        }
        
        selectedAlphabet = alphabet[indexPath.row]
        
        userDefault.set(selectedAlphabet!, forKey: "brand_initial")

        BrandSelectService.shared.showBrandList { (brandList) in
            self.brand = brandList
            self.tableView.reloadData()
        }

        
    }
}


extension BrandSelectVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 90) / 9
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

