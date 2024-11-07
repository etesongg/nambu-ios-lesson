//
//  WebView.swift
//  SwiftUi-Uiket
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var strURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: strURL) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


#Preview {
    WebView(strURL:.constant("https://naver.com"))
}
