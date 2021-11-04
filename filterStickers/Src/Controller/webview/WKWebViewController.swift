//
//  WKWebViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/14.
//

import Foundation
import UIKit
import WebKit
class WKWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    var webView:WKWebView!
    var url:String?
    
    lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: 0, width: 50 , height: 50)
        button.tag = 0
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "setting_back"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let config = WKWebViewConfiguration()
        let userContent = WKUserContentController()
        userContent.add(self, name: "NativeMethod")
        config.userContentController = userContent
        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        
        let url = NSURL(string: url!)
        let requst = NSURLRequest(url: url! as URL)
        webView.navigationDelegate = self
        webView.load(requst as URLRequest)
        self.view.addSubview(webView)
        
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            // 判断服务器采用的验证方法
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.previousFailureCount == 0 {
                // 如果没有错误的情况下 创建一个凭证，并使用证书
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential, credential)
            } else {
                // 验证失败，取消本次验证
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
}
