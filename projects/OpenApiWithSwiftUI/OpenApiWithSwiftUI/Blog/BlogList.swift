//
//  BlogList.swift
//  OpenApiWithSwiftUI
//
//  Created by songhee jeong on 11/9/24.
//

import SwiftUI

struct BlogList:View {
    @StateObject var provider = BlogFinder()
    @State private var query:String = ""
    @State private var page = 1
    var body: some View {
        NavigationSplitView {
            VStack {
                SearchBar(searchText: $query) {
                    provider.search(query: query, at: page)
                }
                List(provider.blogs) { blog in
                    NavigationLink {
                        DetailView(strURL: blog.url)
                    } label: {
                        BlogRow(blog: blog)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("블로그 검색")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        WeatherView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            page -= 1
                            provider.search(query: query, at: page)
                        } label: {
                            Image(systemName: "arrow.backward")
                        }.disabled(page <= 1)
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            page += 1
                            provider.search(query: query, at: page)
                        } label: {
                            Image(systemName: "arrow.forward")
                        }.disabled(provider.isEnd)
                        
                    }
                }
                
            }
        } detail: {
            
        }
    }
}

#Preview {
    BlogList()
}
