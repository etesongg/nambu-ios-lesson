//
//  BlogRow.swift
//  OpenApiWithSwiftUI
//
//  Created by songhee jeong on 11/9/24.
//


import SwiftUI

let sampleBlog = Blog(title: "소년이 온다 - 한강", contents: "한강 작가가 한국 최초 노벨문학상을 수상하였는데요. 저의 경우 찾아보니 옛날에 부커상 받을 때 소년이 온다를 구매했더라구요. 2024.10.11 - [News] - 한강 작가 한국 최초 노벨문학상 수상 한강 작가 한국 최초 노벨문학상 수상 한강 작가가 한국 최초로 노벨문학상을 수상했습니다.한강소설가 한강(53)이 한국 작가...", blogname: "Dorulog", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/W5zbWVjrKg", url: "https://dorudoru.tistory.com/559471", id: "934333AA-761B-4B85-B4D5-2D0917A6CE64")

struct BlogRow: View {
    let blog:Blog
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: blog.thumbnail)) { image in
                image.resizable().frame(width: 70, height: 80)
            } placeholder: {
                Image(systemName: "book.closed")
            }
            
            VStack(alignment: .leading) {
                Text(blog.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .lineLimit(1)
                Text(blog.contents)
                    .lineLimit(2)
            }.font(.caption)
        }
    }
}

#Preview {
    BlogRow(blog: sampleBlog)
}
