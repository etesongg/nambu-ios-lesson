//
//  SaleListView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI

struct SaleListView: View {
    @EnvironmentObject var saleVM:SaleViewModel
    var body: some View {
        List(saleVM.sales) { sale in // doucment 하나의 이름을 sale로
            SaleRowView(sale: sale)
        }.onAppear {
            saleVM.fetchSales()
        }
    }
}

#Preview {
    SaleListView()
}
