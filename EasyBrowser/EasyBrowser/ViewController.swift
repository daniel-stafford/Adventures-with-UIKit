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
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]

    override func loadView() {
        // https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        // creates a new UIProgressView instance, giving it the default style. There is an alternative style called .bar, which doesn't draw an unfilled line to show the extent of the progress view, but the default style looks best here.
        progressView = UIProgressView(progressViewStyle: .default)
        // tells the progress view to set its layout size so that it fits its contents fully.
        progressView.sizeToFit()
        // creates a new UIBarButtonItem using the customView parameter, which is where we wrap up our UIProgressView in a UIBarButtonItem so that it can go into our toolbar.
        let progressButton = UIBarButtonItem(customView: progressView)

        // we're creating a new bar button item using the special system item type .flexibleSpace, which creates a flexible space.  t doesn't need a target or action because it can't be tapped
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false

        // Although WKWebView tells us how much of the page has loaded using its estimatedProgress property, the WKNavigationDelegate system doesn't tell us when this value has changed. So, we're going to ask iOS to tell us using a powerful technique called key-value observing, or KVO.
        // We're going to use KVO to watch the estimatedProgress property
        // forKeyPath isn't named forProperty because it's not just about entering a property name. You can actually specify a path: one property inside another, inside another, and so on. More advanced key paths can even add functionality, such as averaging all elements in an array! Swift has a special keyword, #keyPath, which works like the #selector keyword you saw previously: it allows the compiler to check that your code is correct – that the WKWebView class actually has an estimatedProgress property.
        // 👀 Warning: in more complex applications, all calls to addObserver() should be matched with a call to removeObserver() when you're finished observing
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    // Once you have registered as an observer using KVO, you must implement a method called observeValue(). This tells you when an observed value has changed, s
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        //  if the estimatedProgress value of the web view has changed
        if keyPath == "estimatedProgress" {
            // we want to set this to match our webView's estimatedProgress value, which is a number from 0 to 1,
            // Minor note: estimatedProgress is a Double, which as you should remember is one way of representing decimal numbers like 0.5 or 0.55555. Unhelpfully, UIProgressView's progress property is a Float, which is another (lower-precision) way of representing decimal numbers. Swift doesn't let you put a Double into a Float, so we need to create a new Float from the Double.
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    // Because you might call the decisionHandler closure straight away, or you might call it later on (perhaps after asking the user what they want to do), Swift considers it to be an escaping closure. That is, the closure has the potential to escape the current method, and be used at a later date. We won’t be using it that way, but it has the potential and that’s what matters.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        // , "if there is a host for this URL, pull it out" – and by "host" it means "website domain" like apple.com. Note: we need to unwrap this carefully because not all URLs have hosts.
        if let host = url?.host {
            for website in websites {
                // hasPrefix() isn't suitable here because our safe site name could appear anywhere in the URL. For example, slashdot.org redirects to m.slashdot.org for mobile devices, and hasPrefix() would fail that test.
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }

        decisionHandler(.cancel)
    }
}
