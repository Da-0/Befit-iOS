//
//  PostCodeVC.swift
//  Befit
//
//  Created by 이충신 on 31/12/2018.
//  Copyright © 2018 GGOMMI. All rights reserved.
//

import UIKit
import WebKit

class PostCodeVC: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    var webView: WKWebView?
    
    let indicator = UIActivityIndicatorView(style: .gray)
    let unwind = "unwind"
    
    var postCode = ""
    var address = ""
    
    override func loadView() {
        
        super.loadView()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.view = self.webView!
        self.webView?.navigationDelegate = self
        
        self.webView?.addSubview(indicator)
        indicator.center.x = UIScreen.main.bounds.width/2
        indicator.center.y = UIScreen.main.bounds.height/2
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let url = URL(string: "https://trilliwon.github.io/postcode/"),
            let webView = webView else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        self.webView?.navigationDelegate = self
        indicator.startAnimating()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == unwind {
            
            if let destination = segue.destination as? UserInfoAdminVC {
                
                destination.postCodeLabel.text = postCode
                destination.addressLabel.text = address

                let addressBool = postCode == "" || address == ""
                
                //우편번호 검색 이전(버튼만 보여준다)
                destination.postCodeButton.isHidden = addressBool ? false : true
                //우편번호 검색완료 이후
                destination.postView.isHidden = addressBool ? true : false

            }
        }
        
    }

    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let postCodData = message.body as? [String: Any] {
            
            postCode = postCodData["zonecode"] as? String ?? ""
            address = postCodData["addr"] as? String ?? ""
            
        }
        
        performSegue(withIdentifier: unwind, sender: nil)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        indicator.stopAnimating()
    }
}
