//
//  LikeVC.swift
//  Befit
//
//  Created by 이충신 on 25/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LikeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToViewController(at: 0)
        
    }

    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        
        let child1 = UIStoryboard(name: "Like", bundle: nil).instantiateViewController(withIdentifier: "LikeProductCVC") as! LikeProductCVC
        let child2 = UIStoryboard(name: "Like", bundle: nil).instantiateViewController(withIdentifier: "LikeBrandTVC") as! LikeBrandTVC
        
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
        settings.style.selectedBarHeight = 1.0
        settings.style.selectedBarBackgroundColor = .black // 선택되었을경우
        settings.style.selectedBarVerticalAlignment = .bottom //****
        
        
        //containerView.frame.origin.y = 104//****
        //buttonBarView.frame.contains(CGRect(x: 0, y: 300, width: 375, height: 812))//****
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
    }
}







