//
//  SampleView.swift
//  SwiftUiStateTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        StateTestView(displayStr: "Hello @State")
    }
}

struct StateTestView:View {
    @State var displayStr:String
    var body: some View {
        Text(displayStr)
    }
}

#Preview {
    StateTestView(displayStr: "Hello")
}
