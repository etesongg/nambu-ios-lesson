//
//  BlogFinder.swift
//  OpenApiWithSwiftUI
//
//  Created by songhee jeong on 11/9/24.
//

import Foundation
import Alamofire

class BlogFinder:ObservableObject {
    @Published var blogs:[Blog] = []
    @Published var isEnd = true
    @Published var isError = false
    let endPoint = "https://dapi.kakao.com/v2/search/blog"
    let apiKey = "KakaoAK f7c7112906d3b52496f962ae3ea546bb"
    
    func search(query:String, at page:Int){
        let headers:HTTPHeaders = ["Authorization":apiKey]
        let params: Parameters = ["query": query, "page":page]
        AF.request(endPoint, method: .get, parameters: params, headers: headers)
            .validate(statusCode: 200..<300) // 200~300 미만
            .responseDecodable(of: BlogRoot.self) { response in
                switch response.result {
                case .success(let blogroot):
                    self.blogs = blogroot.blogs
//                    print(self.blogs)
                    self.isEnd = blogroot.meta.isEnd
                    self.isError = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isError = true
                }
            }
    }
}
