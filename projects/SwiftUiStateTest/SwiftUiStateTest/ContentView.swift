//
//  ContentView.swift
//  SwiftUiStateTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

struct ContentView: View {
    @State var framework = "Hello, UIkit"
    var body: some View {
        VStack {
            Text(framework)
                .font(.title)
            Button(action: {
                framework = "Hello, SwiftUI!"
            }, label: {
                Text("Framework 변경")
            })
        }
    }
}

#Preview {
    ContentView()
}
