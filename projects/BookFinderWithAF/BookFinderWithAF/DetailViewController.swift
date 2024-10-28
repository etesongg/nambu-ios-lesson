//
//  DetailViewController.swift
//  BookFinderWithAF
//
//  Created by 정송희 on 10/28/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var strUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let strUrl, let url = URL(string: strUrl)
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
