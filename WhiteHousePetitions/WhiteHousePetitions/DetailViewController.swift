//
//  DetailViewController.swift
//  WhiteHousePetitions
//
//  Created by Daniel Stafford on 1/4/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        body {
        font-size: 150%;
        text-align: justify;
        text-justify: inter-word;
        padding: 10px;
        </style>
        </head>
        <body>
        <h3>\(detailItem.title)</h2>
        <h4>\(detailItem.signatureCount) signatures</h4>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}
