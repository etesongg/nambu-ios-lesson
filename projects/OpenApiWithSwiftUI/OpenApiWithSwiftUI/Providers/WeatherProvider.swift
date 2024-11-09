//
//  WeatherProvider.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import Foundation
import Alamofire

class WeatherProvider:ObservableObject {
    @Published var main:String = ""
    @Published var description:String = ""
    @Published var icon:String = ""
    @Published var temp:Double?
    let endPoint = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "e60241c0f4d9ba4af2de1c75ba7a2162"
    
    func getWeather() {
        let params:Parameters = ["q":"seoul", "appid":appid, "lang":"kr", "units":"metric"]
        AF.request(endPoint, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Result.self) { response in
                switch response.result {
                case .success(let result):
                    let weather = result.weather[0]
                    self.main = weather.main
                    self.temp = result.main.temp
                    self.description = weather.description
                    self.icon = "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
