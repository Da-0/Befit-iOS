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

class SearchBrandVC: UIViewController {

    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let userDefault = UserDefaults.standard
    
    var searchBrandList:[Brand]? = []
    var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(searchListen), name: Notification.Name(rawValue: "searchEnd"), object: nil)
    }
    
    @objc func searchListen(){
        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let keyword = userDefault.string(forKey: "SearchKeyword") else {return}
        searchKeyword = keyword
        searchBrnad(keyword: searchKeyword)
    }
  
}


extension SearchBrandVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let brand = searchBrandList else {
            noResultView.isHidden = false
            return 0
        }
        return brand.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brandVC  = Storyboard.shared().brand.instantiateViewController(withIdentifier: "BrandVC")as! BrandVC
        brandVC.brandInfo = searchBrandList?[indexPath.row]
        self.navigationController?.pushViewController(brandVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBrandTVCell", for: indexPath) as! SearchBrandTVCell
        guard let brand = searchBrandList else {return cell}
        
        cell.brandImg.imageFromUrl(brand[indexPath.row].logo_url, defaultImgPath: "")
        cell.brandName.text = brand[indexPath.row].name_english
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
            if res.data != nil {
                self.noResultView.isHidden = true
            }
            else{
                self.noResultView.isHidden = false
            }
            self.tableView.reloadData()
        }
    }
}

    

    
    

