//
//  SearchBrandVC.swift
//  Befit
//
//  Created by 이충신 on 30/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Search.Storyboard
//  2-2) 키워드 검색 결과 관련된 브랜드 목록 보여주는 VC (TableView)


import UIKit
import XLPagerTabStrip

class SearchBrandVC: UITableViewController {

    let userDefault = UserDefaults.standard
    
    var searchBrandList:[Brand]? = []
    var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let keyword = userDefault.string(forKey: "SearchKeyword") else {return}
        searchKeyword = keyword
        searchBrnad(keyword: searchKeyword)
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
        let brandVC  = Storyboard.shared().brand.instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = searchBrandList?[indexPath.row]
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

extension SearchBrandVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
}

//Mark: - Network Service
extension SearchBrandVC {
    func searchBrnad(keyword: String) {
        SearchBrandService.shared.showSearchBrand(keyword: keyword) { (res) in
            self.searchBrandList = res.data
            self.tableView.reloadData()
        }
    }
}

    

    
    

