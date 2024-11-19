//
//  MemberViewModel.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

//ObservableObject
import SwiftUI
import Alamofire
import SVProgressHUD

class MemberViewModel:ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoginError = false // 알럿을 띄우는 binding된 bool값
    @Published var isJoinShowing = false
    @Published var isJoinError = false
    @Published var message = ""
    
    let endPoint = "http://localhost:3000"
    
    init(){ // 이렇게 하면 처음 로그인화면 안 보여줌
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    func login(userName:String, password:String){
        SVProgressHUD.show()
        let url = "\(endPoint)/members/sign-in"
        let params:Parameters = ["userName":userName, "password":password]
        AF.request(url, method: .post, parameters: params)
            .response { response in
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                        case 200..<300:
                        if let data = response.data {
                            do {
                                let signIn = try JSONDecoder().decode(SignIn.self, from: data) // decode 예외처리 해줘야 함
                                self.isLoggedIn = true
                                UserDefaults.standard.set(signIn.token, forKey: "token") // 토큰 저장, forkey로 이름 설정
                                UserDefaults.standard.set(signIn.member.userName, forKey: "userName")
                                UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
                            } catch let error {
                                self.isLoginError = true
                                self.message = error.localizedDescription
                            }
                        }
                        case 300..<600:
                            self.isLoginError = true
                            if let data = response.data{
                                do {
                                    let apiError = try JSONDecoder().decode(APIError.self, from: data)
                                    self.message = apiError.message
                                }catch let error {
                                    self.message = error.localizedDescription
                                }
                            }
                        default:
                        self.isLoginError = true
                        self.message = "알 수 없는 에러가 발생했습니다."
                    }
                }
            }
        SVProgressHUD.dismiss()
    }
    
    func join(userName:String, password:String){
        SVProgressHUD.show()
        let url = "\(endPoint)/members/sign-up"
        let params:Parameters = ["userName":userName, "password":password]
        AF.request(url, method: .post, parameters: params)
            .response { response in
                if let statusCode = response.response?.statusCode {
                    self.isJoinShowing = true // 에러가 나든 성공을 하든 보여주긴 해야함. 그래서 여기에서 true로 해줌
                    switch statusCode {
                        case 200..<300:
                        if let data = response.data {
                            do {
                                let signUp = try JSONDecoder().decode(SignUp.self, from: data) // decode 예외처리 해줘야 함
                                self.message = signUp.message
                            } catch let error {
                                self.message = error.localizedDescription
                            }
                        }
                        case 300..<600:
                            if let data = response.data{
                                do {
                                    let apiError = try JSONDecoder().decode(APIError.self, from: data)
                                    self.message = apiError.message
                                }catch let error {
                                    self.message = error.localizedDescription
                                }
                            }
                        default:
                        self.message = "알 수 없는 에러가 발생했습니다."
                    }
                }
            }
        SVProgressHUD.dismiss()
    }
}
