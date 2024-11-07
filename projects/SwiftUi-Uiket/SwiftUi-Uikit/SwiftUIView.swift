//
//  SwiftUIView.swift
//  SwiftUi-Uiket
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

struct LabelView: UIViewRepresentable { // view 타입 아니어서 body 필요 없음
    @Binding var text:String
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}




#Preview {
    LabelView(text: .constant("Hello World")) // 바인딩된 값 넣을때는 constant로 넣기
}
