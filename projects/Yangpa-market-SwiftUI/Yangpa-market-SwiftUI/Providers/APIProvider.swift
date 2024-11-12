//
//  UserProvider.swift
//  Yangpa-market-SwiftUI
//
//  Created by songhee jeong on 11/12/24.
//

import Alamofire

class APIProvider {
    static let shared = APIProvider() // 싱글톤 생성(하나만 생성해서 어디서든 동일한 인스턴스 사용
    
    func login(userName:String, password:String, completion: @escaping (Result<User, Error>) -> Void) {
        let params:Parameters = ["userName":userName, "password":password]
        
        let url = APIConstants.loginURL
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    print("로그인 성공", user.message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
