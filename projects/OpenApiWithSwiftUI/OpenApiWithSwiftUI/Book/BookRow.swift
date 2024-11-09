//
//  BookRow.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import SwiftUI

let sampleBook = Book(title: "소년이 온다", publisher: "창비", authors: ["한강"], thumbnail: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F532683%3Ftimestamp%3D20241101113734", url: "https://search.daum.net/search?w=bookpage&bookId=532683&q=%EC%86%8C%EB%85%84%EC%9D%B4+%EC%98%A8%EB%8B%A4", price: 15000, id: "8936434128 9788936434120")

struct BookRow: View {
    let book:Book
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.thumbnail)) {
                image in
                image.image?.resizable().frame(width: 60, height: 80)
            }
            
            VStack(alignment: .leading ) {
                Text(book.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .lineLimit(1)
                Text(book.authors.joined(separator: ","))
                    .font(.title3)
                HStack {
                    Text(book.publisher)
                    Spacer()
                    Text("\(book.price)원")
                        .frame(alignment: .trailing)
                        .foregroundStyle(Color.red)
                        
                }
            }
        }
    }
}

#Preview {
    BookRow(book: sampleBook)
}
