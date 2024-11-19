//
//  MainView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var memberVM:MemberViewModel
    @EnvironmentObject var saleVM:SaleViewModel
    var body: some View {
        TabView {
            SaleListView()
                .tabItem {
                Image(systemName: "list.bullet")
                Text("상품목록")
            }
            Text("카카오맵")
                .tabItem {
                    Image(systemName: "map")
                    Text("카카오맵")
                }
            }
    }
}

#Preview {
    let memverVM = MemberViewModel()
    let saleVM = SaleViewModel()
    MainView().environmentObject(memverVM).environmentObject(saleVM)
}
