//
//  SearchVC2.swift
//  Befit
//
//  Created by 이충신 on 29/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchVC2: ButtonBarPagerTabStripViewController  {
    
    
    var searchController : UISearchController!
    var keyword: String?
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
        initSearchBar()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        moveToViewController(at: 0)
    }

    // willMove -> It appears on the parent screen.
    override func willMove(toParent parent: UIViewController?) {
        print(#function)
        if let `parent` = parent as? SearchVC {
            parent.delegate = self
        }
    }
    
    // It appears on the parent screen. -> didMove
    override func didMove(toParent parent: UIViewController?) {
        print(#function)
        if let `parent` = parent as UIViewController? {
            print(parent)
        }
    }
    
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        
        let child1 = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
        child1.searchKeyword = self.keyword ?? ""
        let child2 = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchBrandTVC") as! SearchBrandTVC
        
        return [child1, child2]
    }
    
    
    func configureButtonBar() {
        
        // Sets the background colour of the pager strip and the pager strip item
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        
        // Sets the pager strip item font and font color
        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 14.0)!
        settings.style.buttonBarItemTitleColor = .black
        
        
        // Sets the pager strip item offsets
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        // Sets the height and colour of the slider bar of the selected pager tab
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .black
        settings.style.selectedBarVerticalAlignment = .bottom
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
    }
}
    


extension SearchVC2 : UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        print("hello world!")
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

extension SearchVC2: SearchKeywordDelegate {
    func didSearch(keyword: String) {
        self.keyword = keyword
        self.buttonBarView.reloadData()
    }
}




   
    
    

