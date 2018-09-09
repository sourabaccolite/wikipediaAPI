//
//  WikiWebViewController.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit
import WebKit

class WikiWebViewController: SuperViewController {
    
    @IBOutlet weak var webViewWiki: WKWebView!
    @IBOutlet weak var activityIndicatorWebView: UIActivityIndicatorView!

    @IBOutlet weak var barButtonItemBack: UIBarButtonItem!
    @IBOutlet weak var barButtonItemRefresh: UIBarButtonItem!
    @IBOutlet weak var barButtonItemForward: UIBarButtonItem!
    
    var strWikiPageUrl: String?
    var strPageTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let strPageTtl = strPageTitle {
           self.title = strPageTtl
        }
        
        setUpUI()
        webViewWiki.navigationDelegate = self
        loadWikiPageInWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpUI() {
        barButtonItemBack.isEnabled = false
        barButtonItemRefresh.isEnabled = false
        barButtonItemForward.isEnabled = false
    }
    
    func loadWikiPageInWebView() {
        if strWikiPageUrl != nil,
            let url = URL.init(string: strWikiPageUrl!) {
            let urlRequest = URLRequest(url: url)
            webViewWiki.load(urlRequest)
        }
    }
    
    @IBAction func webViewActionBack(_ sender: Any) {
        webViewWiki.goBack()
    }
    
    @IBAction func webViewActionReload(_ sender: Any) {
        webViewWiki.reload()
    }
    
    @IBAction func webViewActionForward(_ sender: Any) {
        webViewWiki.goForward()
    }
}

extension WikiWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorWebView.startAnimating()
        barButtonItemRefresh.isEnabled = false
        WikiLog().print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicatorWebView.stopAnimating()
        barButtonItemRefresh.isEnabled = true
        WikiLog().print("didCommit navigation")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        WikiLog().print("didFinish navigation")
        barButtonItemBack.isEnabled = webView.canGoBack
        barButtonItemRefresh.isEnabled = true
        barButtonItemForward.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        barButtonItemRefresh.isEnabled = true
        WikiLog().print("didFail navigation")
    }
}
