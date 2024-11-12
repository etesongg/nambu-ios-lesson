//
//  LoginView.swift
//  Yangpa-market-SwiftUI
//
//  Created by songhee jeong on 11/13/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("로그인")
                .font(.largeTitle)
                .bold()
            
            TextField("아이디", text: $viewModel.userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("비밀번호", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.login()
            }) {
                Text("로그인")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Text(viewModel.loginMessage)
                .foregroundColor(viewModel.isLoggedIn ? .green : .red)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Login", displayMode: .inline)
    }
}

#Preview {
//    LoginView(viewModel: )
}
