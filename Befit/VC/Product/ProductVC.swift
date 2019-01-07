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

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    
    var address: String?
    var brandName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(address)
        print("http://" + address!)
        print(brandName)
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
    
    
    
    @IBAction func sizeCheckAction(_ sender: Any) {
        //사이즈체크 팝업 뷰가 뜹니다.
    }
    
    
    
    
    
}
