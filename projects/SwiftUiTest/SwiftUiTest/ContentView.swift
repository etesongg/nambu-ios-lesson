//
//  ContentView.swift
//  SwiftUiTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, SwiftUI")
            .foregroundStyle(.red)
            .bold()
            .padding()
            .background(.blue)
        VStack {
            Image("bts1")
                .resizable()
                .frame(width: 100, height: 150)
        }

        Button("I'm button") {
            print("버튼이 눌러졌습니다.")
        }
        
        VStack {
            Button {
                print("두번째 버튼이 눌러졌습니다.")
            } label: {
                return Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height:100)
        }
        }
        
        VStack(alignment: .trailing) {
            Text("VStack")
            Text("Hello, Stack!")
                .foregroundStyle(.blue)
                .padding()
                .background(Color.red)
            Text("Hello, SwiftUI!")
                .foregroundStyle(.red)
                .padding()
                .bold()
                .background(Color.blue)
        }
        
        HStack {
            Text("HStack")
            Text("Hello, Stack!")
                .foregroundStyle(.blue)
                .padding()
                .background(Color.red)
            Text("Hello, SwiftUI!")
                .foregroundStyle(.red)
                .padding()
                .bold()
                .background(Color.blue)
            SampleView()
        }
        
        ZStack {
            Text("Hello, SwiftUI!")
                .foregroundStyle(.red)
                .padding()
                .bold()
                .background(Color.blue)
            Text("Hello, Stack!")
                .foregroundStyle(.blue)
                .padding()
                .background(Color.red)
            Text("ZStack")
        }
        
        SampleView()
    }
}

#Preview {
    ContentView()
}
