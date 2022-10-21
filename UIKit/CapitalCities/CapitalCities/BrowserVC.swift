//
//  BrowserVC.swift
//  CapitalCities
//
//  Created by Daniel Stafford on 1/13/22.
//

import UIKit
import WebKit

class BrowserVC: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var selectedWebsite: String?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + selectedWebsite! )!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
