//
//  AddInfoViewController.swift
//  PlaceIn
//
//  Created by 정송희 on 9/10/24.
//

import UIKit
import WebKit

class AddInfoViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var titleKeyword: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let titleKeyword = titleKeyword else { return }
        guard let keyword = titleKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://search.naver.com/search.naver?ssc=tab.nx.all&where=nexearch&sm=tab_jum&query=\(keyword)") else { return }
        
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
