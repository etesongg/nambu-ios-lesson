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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func search(text: String?) {
        guard let text else { return }
        print(text)
        let url = "\(TRANS_ENDPOINT)/translate?api-version=3.0&to=en,ja,fr,zh"
        print(url)
        
        let params: [String: Any] = ["Text": text] // 입력값 형태, 전송될 데이터 형태
        
        var headers: HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": TRANS_KEY,
            "Ocp-Apim-Subscription-Region": "eastus",
            "Content-Type": "application/json"
        ]
        
        // 리퀘스트
        let alamo = AF.request(url, method: .post, parameters: params, encoding: ArrayEncoding(), headers: headers)
        
        alamo.responseDecodable(of: [TranslationResult].self) { response in // 응답 데이터를 [TranslationResult] 타입으로 디코딩하라고 지시
            switch response.result {
            case .success(let results):
                self.translation = results.first?.translations
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print("Error: \(error)")
                print("Received data: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")")
            }
            
        }
        
        // httpBody에서 데이터 꺼내기(디버깅)
        if let urlRequest = try? alamo.convertible.asURLRequest(),
           let httpBody = urlRequest.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            print("Request body: \(bodyString)")
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

// 인코딩된 URL 요청 반환
struct ArrayEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest() // URLRequest 타입으로 변환
        guard let parameters = parameters else { return request }
        
        // 파라미터 -> json 데이터 변환
        // paramters => ["Text": "안녕"]
        // [parameters] => [["Text": "안녕"]]
        // JSONSerialization.data => [{"Text":"안녕"}]
        // 바이트 배열(Data 타입)로 변환되어 data에 저장
        let data = try JSONSerialization.data(withJSONObject: [parameters], options: [])
        
        request.httpBody = data // 바디에 넣기
        
        return request
    }
}
