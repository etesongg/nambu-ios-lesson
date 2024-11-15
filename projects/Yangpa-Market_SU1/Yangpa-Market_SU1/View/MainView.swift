//
//  MainView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var memberVM:MemberViewModel //
    var body: some View {
        SaleListView().padding()
        Button("로그아웃") {
            memberVM.isLoggedIn = false
        }
    }
}

#Preview {
    MainView()
}
