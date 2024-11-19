//
//  LoginView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var memberVM:MemberViewModel //
    @State var userId:String=""
    @State var password:String=""
    
    var body: some View {
        VStack{
            VStack {
                CustomTextField(icon: "person.fill", placeholder: "ID를 입력하시오.", text: $userId)
                CustomTextField(icon: "lock.fill", placeholder: "비밀번호를 입력하시오.", text: $password, isSecured: true)
            }.padding(.bottom, 20)
            
            VStack {
                WideImageButton(icon: "person.badge.key", title: "로그인", backgroundColor: .orange){
                    memberVM.login(userName: userId, password: password) //
                }.alert("로그인 실패", isPresented: $memberVM.isLoginError) {
                    Button("확인") {
                        memberVM.isLoginError = false
                    }
                } message: {
                    Text(memberVM.message)
                }
                
                WideImageButton(icon: "person.badge.plus", title: "회원가입", backgroundColor: .green){
                    memberVM.join(userName: userId, password: password)
                }.alert("회원가입 실패", isPresented: $memberVM.isJoinShowing) {
                    Button("확인") {
                        memberVM.isJoinShowing = false
                    }
                } message: {
                    Text(memberVM.message)
                }
            }
        }

    }
}

#Preview {
    LoginView()
}
