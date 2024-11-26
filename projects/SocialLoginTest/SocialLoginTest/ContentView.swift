//
//  ContentView.swift
//  SocialLoginTest
//
//  Created by 정송희 on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SignInWithAppleView()
            KaKaoLoginView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
