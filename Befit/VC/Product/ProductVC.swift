//
//  ProductVC.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit
import WebKit

class ProductVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var loading: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    
    var address: String?
    var brandName: String?
    var productInfo: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loading.isHidden = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.topItem?.title = brandName
        
        self.request(url: "https://" + address!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    // 현재 webView에서 받아온 URL 페이지를 로드한다.
    func request(url: String) {
        
        self.webView.load(URLRequest(url: URL(string: url)!))
        
        //self.webView.navigationDelegate = self;
    }
    
    @IBAction func dismisssAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("startttt")
//        //        loading.isHidden = false
//        //        webView.isHidden = true
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        //        loading.isHidden = true
//        //        webView.isHidden = false
//        print("finishhhhhhh")
//        loading.delete(loading)
//
//    }
    
    
    
    @IBAction func sizeCheckAction(_ sender: Any) {
        
        //사이즈체크 팝업 뷰가 뜹니다.
        let sizeCheckVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "SizeCheckVC")as! SizeCheckVC
        sizeCheckVC.productInfo = self.productInfo
        self.addChild(sizeCheckVC)
        
        sizeCheckVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(sizeCheckVC.view)
        sizeCheckVC.didMove(toParent: self)
        
    }
    
    
    
    
    
}
