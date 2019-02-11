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
    
    var webView: WKWebView?
    @IBOutlet weak var webContent: UIView!
    @IBOutlet weak var lottieView: UIView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var sizeCheckBtn: UIBarButtonItem!
    @IBOutlet weak var bodyMove: UIImageView!
    
    var aniView = LOTAnimationView(name: "animation")
    
    var productInfo: Product?
    var brandInfo: Brand?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        webView?.navigationDelegate = self;
        self.webContent.addSubview(webView!)
        self.bodyMove.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/20)
        sizeCheckBtn.isEnabled = false
        sizeCheckBtn.image = nil
    }
    
    
    func animate() {
        aniView.frame = bodyMove.frame
        aniView.contentMode = .scaleAspectFill
        aniView.autoReverseAnimation = true
        aniView.animationSpeed = 1.5
        self.lottieView.addSubview(aniView)
        aniView.loopAnimation = true
        aniView.play()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        //1) 브랜드 홈페이지 보여주는 경우
        if brandInfo != nil {
             navigationBar.topItem?.title = brandInfo?.name_english
            
            if let link = brandInfo?.link {
                
                let str_url = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                self.request(url: str_url!)
                print("\n브랜드 페이지 url = " + "http://" + str_url!)
            }
            sizeCheckBtn.isEnabled = false
            sizeCheckBtn.image = nil
            
        }
            
        //2) 상품 페이지를 보야주는 경우
        else if productInfo != nil {
            navigationBar.topItem?.title = productInfo?.name_English
            
            if let link = productInfo?.link {
                let str_url = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                self.request(url: "http://" + str_url!)
                print("\n상품 페이지 url = " + "http://" + str_url!)
            
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // 현재 webView에서 받아온 URL 페이지를 로드한다.
    func request(url: String) {
        self.webView?.load(URLRequest(url: URL(string: url)!))
       
    }
    
    // 뒤로가기 버튼
    @IBAction func dismisssAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사이즈 체크 버튼(PopUp)
    @IBAction func sizeCheckAction(_ sender: Any) {
    
        let sizeCheckVC = Storyboard.shared().product.instantiateViewController(withIdentifier: "SizeCheckVC")as! SizeCheckVC
        sizeCheckVC.productInfo = self.productInfo
        
        self.addChild(sizeCheckVC)
        sizeCheckVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(sizeCheckVC.view)
        sizeCheckVC.didMove(toParent: self)
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("didFinish")
//        lottieView.isHidden = true
//        if brandInfo == nil {
//            sizeCheckBtn.isEnabled = true
//            sizeCheckBtn.image = #imageLiteral(resourceName: "sizeCheckButton")
//        }
//        aniView.stop()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start!")
        animate()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Commit!")
        lottieView.isHidden = true
        if brandInfo == nil {
            sizeCheckBtn.isEnabled = true
            sizeCheckBtn.image = #imageLiteral(resourceName: "sizeCheckButton")
        }
        aniView.stop()
    }
    
    
}

