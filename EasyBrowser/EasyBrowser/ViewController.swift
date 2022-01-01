//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Daniel Stafford on 1/1/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func loadView() {
        // https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://developer.apple.com/documentation/uikit")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
