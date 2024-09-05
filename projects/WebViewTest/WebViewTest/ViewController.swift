//
//  ViewController.swift
//  WebViewTest
//
//  Created by 정송희 on 9/5/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://daum.net")
        guard let url = url else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }

    
}

