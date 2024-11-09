//
//  ForecaseProvider.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import Foundation
import Alamofire

class ForecaseProvider:ObservableObject {
    @Published var list:[Forecast]?
    @Published var isError = false
    let endPoint = "https://api.openweathermap.org/data/2.5/forecast"
    let appid = "e60241c0f4d9ba4af2de1c75ba7a2162"
    
    func getForecase(city:String) {
        let params:Parameters = ["q":city, "appid":appid, "lang":"kr", "units":"metric"]
        AF.request(endPoint, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Root.self) { response in
                switch response.result {
                case .success(let forecasts):
                    self.list = forecasts.list
//                    print(forecasts.list)
                    self.isError = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isError = true
                }
            }
    }
}

