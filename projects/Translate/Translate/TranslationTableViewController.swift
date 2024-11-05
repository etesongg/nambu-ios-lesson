//
//  TranslationTableViewController.swift
//  Translate
//
//  Created by songhee jeong on 11/4/24.
//

import UIKit
import Alamofire

class TranslationTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var translation: [Translation]?
    let TRANS_ENDPOINT = "https://api.cognitive.microsofttranslator.com"
    let TRANS_KEY = "C3pZnYIv9o3UA3GuegwMQWmbTkPa0XVcCyBI1mIKK9DRqO7YoJKLJQQJ99AKACYeBjFXJ3w3AAAbACOGV4xv"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func search(text: String?) {
            guard let text else { return }
            print(text)
            let urlString = "\(TRANS_ENDPOINT)/translate?api-version=3.0&to=en,ja,fr,zh,es"
            guard let url = URL(string: urlString) else {
                return
            }
            print(url)
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let headers: HTTPHeaders = [
                "Ocp-Apim-Subscription-Key": TRANS_KEY,
                "Ocp-Apim-Subscription-Region": "eastus",
                "Content-Type": "application/json"
            ]
            
            // json 데이터 직접 생성
            let jsonBody: [[String: Any]] = [["Text": text]]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
                
                // body 설정
                urlRequest.httpBody = jsonData
                
                headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.name) }
                
                // 리퀘스트
                AF.request(urlRequest).responseDecodable(of: [TranslationResult].self) { response in
                    switch response.result {
                    case .success(let results):
                        self.translation = results.first?.translations
                        DispatchQueue.main.async { self.tableView.reloadData() }
                    case .failure(let error):
                        print("\(error)")
                    }
                }
            } catch {
                print("\(error)")
            }
}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return translation?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "language", for: indexPath)

        guard let trans = translation?[indexPath.row] else { return cell }
        
        let lblTo = cell.viewWithTag(1) as? UILabel
        let lblText = cell.viewWithTag(2) as? UILabel
        
        lblTo?.text = trans.to
        lblText?.text = trans.text

        return cell
    }
    


}

extension TranslationTableViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(text:searchBar.text)
        searchBar.resignFirstResponder() // 키보드 숨기기
    }
}

//// 인코딩된 URL 요청 반환
//struct ArrayEncoding: ParameterEncoding {
//    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var request = try urlRequest.asURLRequest() // URLRequest 타입으로 변환
//        guard let parameters = parameters else { return request }
//        
//        // 파라미터 -> json 데이터 변환
//        // paramters => ["Text": "안녕"]
//        // [parameters] => [["Text": "안녕"]]
//        // JSONSerialization.data => [{"Text":"안녕"}]
//        // 바이트 배열(Data 타입)로 변환되어 data에 저장
//        let data = try JSONSerialization.data(withJSONObject: [parameters], options: [])
//        
//        request.httpBody = data // 바디에 넣기
//        
//        return request
//    }
//}
