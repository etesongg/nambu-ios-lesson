//
//  MainTableViewController.swift
//  Translator-test
//
//  Created by 정송희 on 11/5/24.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    let TRANS_ENDPOINT = "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0"
    let TRANS_KEY = "C3pZnYIv9o3UA3GuegwMQWmbTkPa0XVcCyBI1mIKK9DRqO7YoJKLJQQJ99AKACYeBjFXJ3w3AAAbACOGV4xv"
    let region = "eastus"
    let targetLanguage = "en,ja,fr,zh,es"
    var translations:[Translation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return translations?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let translation = translations?[indexPath.row] else { return cell }
        var config = cell.defaultContentConfiguration()
        config.text = "\(translation.to) : \(translation.text)"
        cell.contentConfiguration = config
        return cell
    }


}

extension MainTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let strURL = "\(TRANS_ENDPOINT)&to=\(targetLanguage)"
        let body = [Text(text: text)]
        let headers:HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": TRANS_KEY,
            "Ocp-Apim-Subscription-Region": region,
            "Content-Type": "application/json"
        ]
        
        let alamo = AF.request(strURL, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
        alamo.responseDecodable(of: [Document].self) { response in
            switch response.result {
            case .success(let docs):
                self.translations = docs.first?.translations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else { return }
//        let strURL = "\(TRANS_ENDPOINT)&to=\(targetLanguage)"
//        let body = [Text(text: text)]
//        guard let url = URL(string: strURL) else { return }// URL 옵셔널 반환
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        // body 설정
//        request.httpBody = try! JSONEncoder().encode(body)
//        // header 설정
//        request.addValue(TRANS_KEY, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
//        request.addValue(region, forHTTPHeaderField: "Ocp-Apim-Subscription-Region")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        AF.request(request).responseDecodable(of: [Document].self) { response in
//            switch response.result {
//            case .success(let docs):
//                self.translations = docs.first?.translations
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let e):
//                print(e.localizedDescription)
//            }
//        }
//        
//    }
}
