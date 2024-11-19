//
//  SaleListView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct SaleListView: View {
    @EnvironmentObject var saleVM:SaleViewModel
    @EnvironmentObject var memberVM:MemberViewModel
    var body: some View {
//        List(saleVM.sales) { sale in // doucment 하나의 이름을 sale로
//            SaleRowView(sale: sale)
//        }.onAppear {
//            saleVM.fetchSales()
//        }
        NavigationSplitView {
            ScrollView {
                LazyVStack { // 보여지기 직전에 만들어짐
                    ForEach(saleVM.sales) { sale in // 모델에서 documents 의미하는데 이름을 sale로 한거임
                        NavigationLink{
                            SaleRowView(sale: sale)
                        } label: {
                            SaleRowView(sale: sale)
                                .padding(.horizontal)
                        }.onAppear {
                            if sale == saleVM.sales.last {
                                saleVM.fetchSales()
                            }
                        }
  
                    }                        .listStyle(.plain)
                        .navigationTitle("판매목록")
                        .navigationBarTitleDisplayMode(.inline)
                    
                }.onAppear {
                    saleVM.fetchSales()
                }.toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink { // 화면전환
                            SaleAddView()
                        } label: {
                            Image(systemName: "plus.app")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button { // 액션을 줄거면 버튼 주기
                            memberVM.isLoggedIn = false
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }

                    }
                }
            }.alert("판매목록", isPresented: $saleVM.isFetchError) {
                Button("확인") {}
            } message: {
                Text(saleVM.message)
            }

        }detail: {
            Text("판매목록")
        }
    }
}

#Preview {
    let saleVM = SaleViewModel()
    SaleListView().environmentObject(saleVM)
}
