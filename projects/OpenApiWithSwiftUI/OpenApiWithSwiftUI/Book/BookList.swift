//
//  BookList.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import SwiftUI

struct BookList: View {
    @State private var query:String = "" // 바인딩한 값을 옵셔널로 정의해놓으면 불편하기 때문에 ""로 정의
    @StateObject var bookFinder = BookFinder()
    @State private var page = 1
    var body: some View {
        NavigationSplitView {
            VStack {
                SearchBar(searchText: $query) {
                    page = 1
                    bookFinder.search(query: query, at: page)
                }.alert("책검색", isPresented: $bookFinder.isError) {
                    Button("확인", role: .cancel) {}
                } message: {
                    Text("책 정보를 가져오는데 실패했습니다.")
                }
                List(bookFinder.books) { book in
                    NavigationLink{
                        DetailView(strURL: book.url)
                    } label: {
                        BookRow(book: book)
                    }
                
                }
                .listStyle(.plain)
                .navigationTitle("책검색")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        WeatherView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            page -= 1
                            bookFinder.search(query: query, at: page)
                        }
                        label: {
                            Image(systemName: "arrow.backward.square")
                        }.disabled(page <= 1)

                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            page += 1
                            bookFinder.search(query: query, at: page)
                        } label: {
                            Image(systemName: "arrow.forward.square")
                        }.disabled(bookFinder.isEnd)

                    }
                }
            }
        } detail: {
        
        }
    }
}

#Preview {
    BookList()
}
