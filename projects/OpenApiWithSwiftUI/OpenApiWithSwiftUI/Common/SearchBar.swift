//
//  SearchBar.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText:String
    @State var isEditing = false
    var handler:()->Void
    var body: some View {
        HStack {
            TextField("검색어를 입력하세요", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 15))
                .padding(.horizontal, 10) // 양옆, leading: 왼쪽
                .onSubmit {
                    handler()
                }
                .onTapGesture { // 탭시 isEditing 변경
                    isEditing = true
                }.animation(.easeOut, value: isEditing)
            if isEditing {
                Button { // state에 따라서 버튼이 보였다가 안 보였다 함
                    isEditing = false
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 15)
                .transition(.move(edge: .trailing)) // 사라지기 방향
                
            }
        }
    }
}

#Preview {
    SearchBar(searchText: .constant("한강")){
    }
}
