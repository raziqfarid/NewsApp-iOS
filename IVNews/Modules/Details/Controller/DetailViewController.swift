//
//  DetailViewController.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: BaseViewController{
    
    /// Displays the details of the news
    @IBOutlet weak var webView: WKWebView!
    
    /// holds the url to be loaded in webview
    var webUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: webUrl) else {
            showAlertMessage(message: "Invalid News URL")
            return
        }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
}
extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoader()
    }
}
