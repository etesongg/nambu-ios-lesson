//
//  SampleView.swift
//  SwiftUiTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        
        ZStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 100, height:100)
            Text("Hello, SampleView!")
                .foregroundStyle(.red)
                .padding()
                .bold()
                .background(Color.blue)
            Text("Hello, Stack!")
                .foregroundStyle(.blue)
                .padding()
                .background(Color.red)
            Text("SampleView")
        }
    }
}

#Preview {
    SampleView()
}
