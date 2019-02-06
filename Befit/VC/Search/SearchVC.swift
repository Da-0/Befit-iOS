//
//  SearchVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Search.Storyboard
//  0) SearchVC1과 SearchVC2를 담는 컨테이너 뷰 + SearchBar

import UIKit
class SearchVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    var searchController : UISearchController!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    private var didTapDeleteKey = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        secondView.isHidden = true
        
    }
}
extension SearchVC : UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchText == "" {
            self.firstView.isHidden = false
            self.secondView.becomeFirstResponder()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // print("키보드 입력중...")
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        firstView.isHidden = true
        secondView.isHidden = true
        self.searchController.searchBar.showsCancelButton = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.secondView.becomeFirstResponder()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchKeyword = searchBar.text else {return}
        userDefault.set(searchKeyword, forKey: "SearchKeyword")
        
        self.view.endEditing(true)
        self.searchController.searchBar.showsCancelButton = false
     
        firstView.isHidden = true
        secondView.isHidden = false
        
        let searchVC2 = Storyboard.shared().search.instantiateViewController(withIdentifier: "SearchVC2") as! SearchVC2
        searchVC2.updateSearchResults(for: searchController)
//        let vc = Storyboard.shared().search.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
//        vc.sortingNew(keyword: searchKeyword)
        NotificationCenter.default.post(name: Notification.Name("searchEnd"), object: nil)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        firstView.isHidden = false
        self.secondView.becomeFirstResponder()
        
    }
    func initSearchBar(){
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self;
        self.searchController.delegate = self;
        self.searchController.searchBar.delegate = self;
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.setValue("취소", forKey: "_cancelButtonText")
        
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
    }
}
