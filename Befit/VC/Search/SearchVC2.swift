//
//  SearchVC2.swift
//  Befit
//
//  Created by 이충신 on 29/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//
//  Search.Storyboard
//  2) PagerTab VC (SearchProduct, SearchBrand를 포함하는 VC)

import UIKit
import XLPagerTabStrip

class SearchVC2: ButtonBarPagerTabStripViewController  {
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SearchVC2 ViewWillAppear!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // willMove -> It appears on the parent screen.
    override func willMove(toParent parent: UIViewController?) {
        print(#function)
       
    }
    
    // It appears on the parent screen. -> didMove
    override func didMove(toParent parent: UIViewController?) {
    // print(#function)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        print("호출!!")
        let child1 = Storyboard.shared().search.instantiateViewController(withIdentifier: "SearchProductVC") as! SearchProductVC
        let child2 = Storyboard.shared().search.instantiateViewController(withIdentifier: "SearchBrandVC") as! SearchBrandVC
        
        return [child1, child2]
    }
    
    
//    func setObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//     
//    }
//    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        adjustKeyboardDismissGesture(isKeyboardVisible: true)
//        self.view.frame.origin.y = -120
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        adjustKeyboardDismissGesture(isKeyboardVisible: false)
//        self.view.frame.origin.y = 0
//    }
    
//    
//    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
//        if isKeyboardVisible {
//            if keyboardDismissGesture == nil {
//                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
//                view.addGestureRecognizer(keyboardDismissGesture!)
//            }
//        }
//    }
    
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
        
        moveToViewController(at: 1)
    }
}



extension SearchVC2 : UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        print("hello world!")
//        let vc2 = Storyboard.shared().search.instantiateViewController(withIdentifier: "SearchBrandVC") as! SearchBrandVC
//        moveTo(viewController: vc2)
        
       
      
       
    }
    
}
