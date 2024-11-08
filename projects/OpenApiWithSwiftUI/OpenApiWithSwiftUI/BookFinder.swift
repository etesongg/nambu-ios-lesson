//
//  BookFinder.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import Foundation
import Alamofire

class BookFinder:ObservableObject {
    @Published var books:[Book] = []
    @Published var isEnd = true
    @Published var isError = false
    let endPoint = "https://dapi.kakao.com/v3/search/book"
    let apiKey = "KakaoAK f7c7112906d3b52496f962ae3ea546bb"
    
    func search(query:String, at page:Int){
        let headers:HTTPHeaders = ["Authorization":apiKey]
        let params: Parameters = ["query": query, "page":page]
        AF.request(endPoint, method: .get, parameters: params, headers: headers)
            .validate(statusCode: 200..<300) // 200~300 미만
            .responseDecodable(of: BookRoot.self) { response in
                switch response.result {
                case .success(let bootRoot):
                    self.books = bootRoot.books
                    print(self.books)
                    self.isEnd = bootRoot.meta.isEnd
                    self.isError = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isError = true
                }
            }
    }
}
