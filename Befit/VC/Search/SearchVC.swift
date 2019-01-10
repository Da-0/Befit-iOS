//
//  SearchVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
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
            print("UISearchBar.text cleared!")
            self.firstView.isHidden = false
            self.secondView.becomeFirstResponder()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("키보드 입력중...")
        
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
        
        print("검색완료!")
        
        guard let searchKeyword = searchBar.text else {return}
        userDefault.set(searchKeyword, forKey: "SearchKeyword")
        self.view.endEditing(true)
        self.searchController.searchBar.showsCancelButton = false
        
        firstView.isHidden = true
        secondView.isHidden = false
        
        
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
