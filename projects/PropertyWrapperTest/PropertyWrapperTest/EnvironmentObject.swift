//
//  EnvironmentObject.swift
//  PropertyWrapperTest
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

class DemoData: ObservableObject {
    @Published var userCount: Int = 0
    @Published var newUser:String = ""
    
    init() {
        updateData()
    }
    
    func updateData() {
        userCount += 1
        newUser = "user \(userCount)"
    }
}

struct EnvironmentObjectView1: View {
    @EnvironmentObject var demoData: DemoData
    var body: some View {
        VStack {
            Text("userCount:  \(demoData.userCount)")
            Text("newUser:  \(demoData.newUser)")
                .padding()
            Button(action: {
                demoData.updateData()
            }) {
                Text("Enter new user")
            }
        }
    }
}
struct EnvironmentObjectView2: View {
    @EnvironmentObject var demoData: DemoData
    var body: some View {
        VStack {
            Text("userCount:  \(demoData.userCount)")
            Text("newUser:  \(demoData.newUser)")
                .padding()
            Button(action: {
                demoData.updateData()
            }) {
                Text("Enter new user")
            }
        }
    }
}

// EnvironmentObject 환경을 통해 데이터를 공유함
struct Environment: View {
    let demoData = DemoData()
    var body: some View {
        VStack {
            EnvironmentObjectView1()
            EnvironmentObjectView2()
        }.environmentObject(demoData)
    }
}

#Preview {
    Environment()
}
