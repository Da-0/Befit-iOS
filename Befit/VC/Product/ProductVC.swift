//
//  ProductVC.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit
import WebKit
import Lottie

class ProductVC: UIViewController, WKNavigationDelegate {
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    
    var address: String?
    var brandName: String?
    var productInfo: Product?
    var brandHome: Bool = false
    @IBOutlet weak var sizeCheckBtn: UIBarButtonItem!
    
    private var boatAnimation: LOTAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createAnimation()
   
    }
    
//    func createAnimation(){
//
//        // Create Boat Animation
//        boatAnimation = LOTAnimationView(name: "material_wave_loading")
//
//        // Set view to full screen, aspectFit
//        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        boatAnimation!.contentMode = .scaleAspectFit
//        boatAnimation!.frame = loadingVIew.bounds
//
//        // Add the Animation
//        loadingVIew.addSubview(boatAnimation!)
//
//
//        // The center of the screen, where the boat will start
//        //let screenCenter = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
//
//        // The center one screen height above the screen. Where the boat will end up when the download completes
//        //let offscreenCenter = CGPoint(x: view.bounds.midX, y: -view.bounds.midY)
//
//        // Convert points into animation view coordinate space.
//        //let boatStartPoint = boatAnimation!.convert(screenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
//
//        //let boatEndPoint = boatAnimation!.convert(offscreenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
//        //Play the first portion of the animation on loop until the download finishes.
//       // boatAnimation!.loopAnimation = true
//       // boatAnimation!.play(fromProgress: 0,
//         //                   toProgress: 2,
//          //                  withCompletion: nil)
//
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.topItem?.title = brandName
        
        //브랜드 홈페이지 보여주는 경우
        if brandHome {
            self.request(url: address!)
            sizeCheckBtn.isEnabled = false
            sizeCheckBtn.image = nil
            
        }
        //상품 페이지를 보야주는 경우
        else {
            self.request(url: "https://" + address!)
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // 현재 webView에서 받아온 URL 페이지를 로드한다.
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
    }
    
    @IBAction func dismisssAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sizeCheckAction(_ sender: Any) {
        
        //사이즈체크 팝업 뷰가 뜹니다.
        let sizeCheckVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "SizeCheckVC")as! SizeCheckVC
        sizeCheckVC.productInfo = self.productInfo
        self.addChild(sizeCheckVC)
        
        sizeCheckVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(sizeCheckVC.view)
        sizeCheckVC.didMove(toParent: self)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//
//        loadingVIew.isHidden = false
//        boatAnimation!.play(toProgress: 0.5) {[weak self] (_) in
//            self?.boatAnimation?.loopAnimation = true
//            self?.boatAnimation!.animationSpeed = 1
//            self?.boatAnimation!.play(toProgress: 3, withCompletion: nil)
//        }
        
        
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       // boatAnimation!.loopAnimation = false
//        loadingVIew.isHidden = true
//        self.boatAnimation?.stop()
    }
    
}






