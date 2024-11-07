//
//  StateObject.swift
//  PropertyWrapperTest
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

struct StateObjectView: View {
    @State private var count = 0
    var body: some View {
        Button {
            count += 1
        } label: {
            Text("State: \(count)")
        }
        MyView()
    }
}

final class MyViewModel: ObservableObject {
    @Published var count: Int = 0
    func increment() {
        count += 1
    }
}

struct MyView: View {
//    @ObservedObject var viewModel = MyViewModel() // ObservedObject 사용시 state 변경시 초기화 됨
    @StateObject var viewModel = MyViewModel() // StateObject 사용시 state 변경시 값 변경 안 됨
    var body: some View {
        Button {
            viewModel.increment()
        } label: {
            Text("ObservedObject: \(viewModel.count)")
        }
    }
}

#Preview {
    StateObjectView()
}
