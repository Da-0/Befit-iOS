//
//  SearchVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
    }
    
 


}

extension SearchVC : UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        print("update Search Results")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search!!")
        let search = UIStoryboard.init(name: "Search", bundle: nil)
        let searchVC2 = search.instantiateViewController(withIdentifier: "SearchVC2") as? SearchVC2
        self.navigationController?.pushViewController(searchVC2!, animated: true)
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
