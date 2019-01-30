//
//  ProductVC.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  Product.Storyboard
//  1) 상품정보 웹뷰 VC (+ 브랜드 자사 홈페이지 띄어주는 용도)

import UIKit
import WebKit
import Lottie

class ProductVC: UIViewController, WKNavigationDelegate {
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var sizeCheckBtn: UIBarButtonItem!
    
    var productInfo: Product?
    var brandInfo: Brand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.topItem?.title = productInfo?.name_English
        
        //브랜드 홈페이지 보여주는 경우
        if brandInfo != nil {
            if let link = brandInfo?.link {
                self.request(url: link)
            }
            sizeCheckBtn.isEnabled = false
            sizeCheckBtn.image = nil
            
        }
        //상품 페이지를 보야주는 경우
        else if productInfo != nil {
            if let link = productInfo?.link {
                self.request(url: "https://" + link)
                print("상품 페이지 url = " + "https://" + link)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // 현재 webView에서 받아온 URL 페이지를 로드한다.
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
    }
    
    // 뒤로가기 버튼
    @IBAction func dismisssAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사이즈 체크 버튼(PopUp)
    @IBAction func sizeCheckAction(_ sender: Any) {
        
        let sizeCheckVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "SizeCheckVC")as! SizeCheckVC
        sizeCheckVC.productInfo = self.productInfo
        
        self.addChild(sizeCheckVC)
        sizeCheckVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(sizeCheckVC.view)
        sizeCheckVC.didMove(toParent: self)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
 
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
    
    
}

