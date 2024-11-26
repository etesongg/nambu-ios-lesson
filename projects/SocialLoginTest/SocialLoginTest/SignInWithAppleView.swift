//
//  SigninWithAppleView.swift
//  SocialLoginTest
//
//  Created by 정송희 on 11/26/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    @State private var userId: String?
    @State private var email: String?
    @State private var fullName: PersonNameComponents?
    
    var body: some View {
        VStack {
            SignInWithAppleButton(
                .signIn,
                onRequest: configureAppleSignIn,
                onCompletion: handleAppleSignInResult
            )
            .frame(height: 50)
            .padding()
            
            if let userId = userId {
                Text("User ID: \(userId)")
            }
            if let email = email {
                Text("Email: \(email)")
            }
            if let fullName = fullName {
                Text("Name: \(fullName.givenName ?? "") \(fullName.familyName ?? "")")
            }
        }
    }
    
    func configureAppleSignIn(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handleAppleSignInResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userId = appleIDCredential.user
                let email = appleIDCredential.email
                let fullName = appleIDCredential.fullName
                
                self.userId = userId
                self.email = email
                self.fullName = fullName
                
                if let identityToken = appleIDCredential.identityToken,
                   let idTokenString = String(data: identityToken, encoding: .utf8) {
                    sendToBackend(idToken: idTokenString)
                }
            }
        case .failure(let error):
            print("Apple Sign In failed: \(error.localizedDescription)")
        }
    }
    
    func sendToBackend(idToken: String) {
        guard let url = URL(string: "http://localhost:5001/api/auth/apple") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["authorization": ["id_token": idToken]]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        print("Response: \(json)")
                    }
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
#Preview {
    SignInWithAppleView()
}
