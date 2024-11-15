//
//  SaleViewModel.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI
import Alamofire

class SaleViewModel:ObservableObject {
    @Published var sales:[Document] = [] // 무한스크롤을 할거기때문에 []로 설정
    @Published var message = ""
    @Published var isShowingSales = false
    @Published var isFetchError = false
    @AppStorage("token") var token:String? // UserDefaults에 관한 거
    private var isLoading = false
    private var page = 1
    private let endPoint = "http://localhost:3000"
    
    func fetchSales(size:Int = 10) { // 무한스클로로 할거기때문에 page는 넘기지 않을거임
        guard !isLoading else { return }
        isLoading = true
        let url = "\(endPoint)/sales"
        guard let token = self.token else { return }
        let params:Parameters = ["page":self.page, "size":size]
        let headres:HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        AF.request(url, method: .get, parameters: params, headers: headres)
            .response { response in
                if let statueCode = response.response?.statusCode {
                    switch statueCode {
                        case 200..<300:
                        if let data = response.data {
                            do {
                                let root = try JSONDecoder().decode(SaleRoot.self, from: data)
                                self.sales.append(contentsOf: root.documents) // array이기 때문에 contentsOf로 한번에 추가할 수 있음
                                print(self.sales)
                                self.page += 1
                                if self.sales.isEmpty {
                                    self.isFetchError = true
                                    self.message = "등록된 상품이 없습니다."
                                }
                                
                            }catch let error { // 디코딩 하다가 발생한 에러
                                self.isFetchError = true
                                self.message = error.localizedDescription
                            }
                        }
                        case 300..<600:
                            self.isFetchError = true
                            if let data = response.data {
                                do {
                                    let apiError = try JSONDecoder().decode(APIError.self, from: data)
                                    self.message = apiError.message
                                    
                                }catch let error {
                                    self.message = error.localizedDescription
                                }
                            }
                        default:
                            self.isFetchError = true
                            self.message = "알 수 없는 에러가 발생했습니다."
                    }
                }
                self.isLoading = false
            }
    }
    
    func addSale() {
        
    }
}
