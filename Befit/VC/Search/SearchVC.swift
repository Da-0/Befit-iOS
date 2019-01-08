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
    
//    func searchBar(_ searchBar: UISearchBar,
//                   shouldChangeTextIn range: NSRange,
//                   replacementText text: String) -> Bool
//    {
//        didTapDeleteKey = text.isEmpty
//
//        return true
//    }
//
//    func searchBar(_ searchBar: UISearchBar,
//                   textDidChange searchText: String)
//    {
//        if !didTapDeleteKey && searchText.isEmpty {
//            firstView.isHidden = false
//            secondView.isHidden = true
//        }
//
//        didTapDeleteKey = false
//    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            print("UISearchBar.text cleared!")
            firstView.isHidden = false
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

        return true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("검색완료!")
        self.view.endEditing(true)
        self.searchController.searchBar.showsCancelButton = false
        
        firstView.isHidden = true
        secondView.isHidden = false
        
        
//        let search = UIStoryboard.init(name: "Search", bundle: nil)
//        let searchVC2 = search.instantiateViewController(withIdentifier: "SearchVC2") as? SearchVC2
//        self.navigationController?.pushViewController(searchVC2!, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        firstView.isHidden = false
        print(firstView.isHidden)
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
