//
//  SearchBrandTVC.swift
//  Befit
//
//  Created by 이충신 on 30/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchBrandTVC: UITableViewController {

    let userDefault = UserDefaults.standard
    
    // product model 받아올 변수 선언
    var searchBrandList:[Brand]? = []
    var searchKeyword: String = ""
    
//    @IBOutlet weak var noResultView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let keyword = userDefault.string(forKey: "SearchKeyword") else {return}
        searchKeyword = keyword
        initSearchBrandList()
    }
    
    func initSearchBrandList(){
            
        SearchBrandService.shared.showSearchBrand(keyword: self.searchKeyword) { (res) in
            guard let status = res.status else {return}
           
            self.searchBrandList = res.data
            self.tableView.reloadData()
            
        }
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let brand = searchBrandList else { return 0 }
        return brand.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brandVC  = UIStoryboard(name: "Rank", bundle: nil).instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = searchBrandList?[indexPath.row]
        brandVC.brandIdx = searchBrandList?[indexPath.row].idx
        self.navigationController?.pushViewController(brandVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBrandTVCell", for: indexPath) as! SearchBrandTVCell
        guard let brand = searchBrandList else {return cell}
        
        cell.brandImg.imageFromUrl(brand[indexPath.row].logo_url, defaultImgPath: "")
        cell.brandName.text = brand[indexPath.row].name_english
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SearchBrandTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
}



    

    
    

