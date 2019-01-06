//
//  DescriptionVC.swift
//  Befit
//
//  Created by 박다영 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var xBtn: UIButton!
    var images = [
        "info1",
        "info2",
        "info3",
        "info4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            imageView.contentMode = .scaleAspectFit //  사진의 비율을 맞춤.
            let xPosition = self.view.frame.width * CGFloat(i) // 현재 보이는 스크린에서 하나의 이미지만 보이게 하기 위해
            
            imageView.frame = CGRect(x: xPosition, y: -44, width: self.view.frame.width, height: self.view.frame.height)
            // 즉 이미지 뷰가 화면 전체를 덮게 됨.
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            // 이미지의 사이즈를 파악하고 해당 이미지를 올릴 수 있는 만큼 scroll view의 크기를 늘린 후
            scrollView.addSubview(imageView)
            // 이미지를 scroll view에 붙인다.
            
            // 이미지의 너비가 얼마일지, 이미지가 몇개가 올라갈지 모르기 때문에 그러한 것들을 파악한 후 그에 맞춰 scroll view의 너비를 결정하는 것.
        }
    }
    @IBAction func xAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
