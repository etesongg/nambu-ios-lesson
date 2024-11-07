//
//  ObservableTest.swift
//  PropertyWrapperTest
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

//class DemoData: ObservableObject {
//    @Published var userCount: Int = 0
//    @Published var newUser:String = ""
//    
//    init() {
//        updateData()
//    }
//    
//    func updateData() {
//        userCount += 1
//        newUser = "user \(userCount)"
//    }
//}

struct ObservableTest: View {
    @StateObject var demoData: DemoData = DemoData()
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
        }    }
}



#Preview {
    ObservableTest()
}
