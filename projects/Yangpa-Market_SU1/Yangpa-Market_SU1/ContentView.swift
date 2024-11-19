//
//  ContentView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    let memberVM = MemberViewModel()
    let saleVM = SaleViewModel()
    var body: some View {
        EntryView()
            .environmentObject(memberVM)
            .environmentObject(saleVM)
    }
}

#Preview {
    ContentView()
}
