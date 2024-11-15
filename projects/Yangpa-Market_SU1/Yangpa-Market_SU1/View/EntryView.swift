//
//  EntryView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var memberVM:MemberViewModel
    var body: some View {
        VStack{
            if memberVM.isLoggedIn {
                MainView()
            } else {
                LoginView(userId: "song", password: "song1234").transition(.move(edge: .bottom)) //
            }
        }.animation(.easeOut, value:memberVM.isLoggedIn)
    }
}

#Preview {
    let memberVM = MemberViewModel() // 여기서 생성해줘서 위에 프로퍼티에서 memberVM = MemberViewModel() 이렇게 해주면 안됨
    let saleVM = SaleViewModel()
    EntryView().environmentObject(memberVM).environmentObject(saleVM) // 여기에 추가하면 하위를 environment로 사용할 수 있음??, SaleListView에서 enviroment사용하기 위해 추가한거임
}
