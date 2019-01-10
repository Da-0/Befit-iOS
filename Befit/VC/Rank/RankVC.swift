//
//  RankVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class RankVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var brandRankList = [Brand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brandListInit() 
        
    }
    
    func brandListInit() {
        BrandRankService.shared.showBrandRank { (brandData) in
            self.brandRankList = brandData
            self.tableView.reloadData()
        }
    }

}


extension RankVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandRankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let brand = brandRankList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankTVCell", for: indexPath) as! RankTVCell
        
        cell.rankLB.text = "\(indexPath.row + 1)"
        cell.brandImg.imageFromUrl(brand.logo_url, defaultImgPath: "")
        cell.brandName.text = brand.name_english
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let brandVC  = UIStoryboard(name: "Rank", bundle: nil).instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = brandRankList[indexPath.row]
        brandVC.brandIdx = brandRankList[indexPath.row].idx
        self.navigationController?.pushViewController(brandVC, animated: true)
        
    }
    
    
    
}
