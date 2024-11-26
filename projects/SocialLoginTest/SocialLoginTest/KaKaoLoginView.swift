//
//  KaKaoLoginView.swift
//  SocialLoginTest
//
//  Created by 정송희 on 11/26/24.
//

import SwiftUI

import KakaoSDKUser

struct KaKaoLoginView: View {
    var body: some View {
        Button {
            kakaoLogin()
        } label: {
            Image("kakao_login_large_wide")
                .resizable().frame(maxWidth: .infinity, maxHeight: 55).padding()
        }
    }
    
    fileprivate func fetchUserInfo() {
        UserApi.shared.me { user, error in
            if let error {
                print(error.localizedDescription)
            } else {
                if let id = user?.id {
                    print("kakao_user_id: \(id)")
                }
            }
        }
    }
    
    func kakaoLogin(){
        // 카카오톡 실행 가능한지 먼저 검사
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let error {
                    print(error.localizedDescription)
                }else {
                    print(token!)
                    fetchUserInfo()
                }
            }
        }else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let error {
                    print(error.localizedDescription)
                }else {
                    print(token!)
                    fetchUserInfo()
                }
            }
        }
    }
}

#Preview {
    KaKaoLoginView()
}
