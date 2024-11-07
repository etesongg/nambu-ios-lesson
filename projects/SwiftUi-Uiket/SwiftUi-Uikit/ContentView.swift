//
//  ContentView.swift
//  SwiftUi-Uiket
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var text:String = "Hello"
    var body: some View {
        VStack {
            LabelView(text: $text)
            Button("내용바꾸기") {
                text = "Hello World"
            }
        }
        .padding()
    }
}

struct WebViewContentView: View {
    @State var strURL:String = "https://naver.com"
    var body: some View {
        VStack {
            WebView(strURL: $strURL)
            Button("구글로 가기") {
                strURL = "https://google.com"
            }
        }
        .padding()
    }
}

#Preview {
    WebViewContentView()
}
