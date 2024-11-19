//
//  SaleRowView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/15/24.
//

import SwiftUI
let sample = Document(id: 40, productName: "테이블", description: "하자 없어요 하자 없어요 dfsdfs 하자 없어요 하자 없어요 하자 없어요 sdfsdfsdfdsffsdfsdfsfffffddddddddfffffffffff", price: 30000, photo: "profile1731637339381.png", userName: "song")

struct SaleRowView: View {
    var sale:Document
    var body: some View {
        HStack(spacing: 20) {
            let strURL = "https://sayangpa.blob.core.windows.net/yangpa/\(sale.photo)"
            AsyncImage(url: URL(string: strURL)) { image in
                image.resizable().aspectRatio(contentMode: .fill) // fit으로 하면 가로 세로 어쩌구 보기 안 좋음
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10)).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            } placeholder: {
                Image(systemName: "photo")
            }   // .padding(.trailing, 10)
            VStack(alignment: .leading) {
                HStack {
                    Text(sale.productName).font(.headline).foregroundStyle(.primary)
                        .lineLimit(1)
                    Spacer()
                    Text("\(sale.price)원").font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                }
                Text(sale.description).font(.subheadline).foregroundStyle(.secondary) // 글자색 연해짐
                    .lineLimit(2)
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.blue)
                    Text(sale.userName)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }

        }
    }
}

#Preview {
    SaleRowView(sale: sample)
}
