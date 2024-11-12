//
//  LoginViewModel.swift
//  Yangpa-market-SwiftUI
//
//  Created by songhee jeong on 11/13/24.
//


import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var loginMessage: String = ""
    @Published var isLoggedIn: Bool = false
    
    func login() {
        APIProvider.shared.login(userName: userName, password: password) { result in // @escaping으로 전달 되어야 함
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.loginMessage = user.message
                    self.isLoggedIn = user.success
                    // 토큰 저장
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loginMessage = error.localizedDescription
                }
            }
        }
    }
}
