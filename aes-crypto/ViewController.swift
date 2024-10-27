//
//  ViewController.swift
//  aes-crypto
//
//  Created by vergil on 2024-10-27.
//

import WebKit
import UIKit
class ViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the web view
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)

        // Load the HTML file
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                webView.loadHTMLString(html, baseURL: nil)
            } catch {
                print("Error loading HTML: \(error)")
            }
        }
        
        injectJavaScript();
    }
    
    private func injectJavaScript() {
        // Load the local JavaScript file
        if let scriptPath = Bundle.main.path(forResource: "crypto-js.min", ofType: "js") {
            do {
                let scriptContent = try String(contentsOfFile: scriptPath)
                let userScript = WKUserScript(source: scriptContent,
                                               injectionTime: .atDocumentEnd,
                                               forMainFrameOnly: false)
                webView.configuration.userContentController.addUserScript(userScript)
            } catch {
                print("Error loading JavaScript file: \(error)")
            }
        }
    }
}

