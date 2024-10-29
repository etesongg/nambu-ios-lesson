//
//  StateTest.swift
//  SwiftUiBindingTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

struct StateTest: View {
    @State private var wifiEnabled = true // Toggle이 바뀔때마다 여기도 같이 바뀜
    @State private var name = ""
    var body: some View {
        VStack {
            Toggle(isOn: $wifiEnabled) {
                Text("Enable Wi-fi")
            }
            WifiImageView(wifiEnabled: $wifiEnabled)
            TextField("이름을 입력하시오.", text: $name)
            Text(name)
        }
    }
    
}

struct WifiImageView: View {
    @Binding var wifiEnabled:Bool // 상위 뷰에 데이터 연동
    var body: some View {
        Image(systemName: wifiEnabled ? "wifi":"wifi.slash").resizable()
            .frame(width: 100, height: 90)
    }
}

struct SwiftUIView: View {
    @State var isShow = false
    var body: some View {
        if isShow {
            Text("SwiftUI Lisfecycle")
                .onAppear(perform: {
                    print("On Appear")
                })
                .onDisappear(perform: {
                    print("On Disappear")
                })
        }
        Toggle(isOn: $isShow, label: {
            Text("On/Off")
                .padding()
        })
    }
}

#Preview {
    SwiftUIView()
}
