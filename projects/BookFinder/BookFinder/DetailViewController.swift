//
//  DetailViewController.swift
//  BookFinder
//
//  Created by 정송희 on 9/6/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var strURL:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let strURL, let url = URL(string: strURL)
        else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
