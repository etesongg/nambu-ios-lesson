//
//  ContentView.swift
//  SwiftUiViewsTest2
//
//  Created by 정송희 on 10/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView()
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
