//
//  Model.swift
//  Translator-test
//
//  Created by 정송희 on 11/5/24.
//

import Foundation

struct Text:Codable { // 검색할때 
    let text:String
}

struct Translation:Codable, Sendable {
    let text:String
    let to:String
}

struct Document:Codable, Sendable { // responseDecodable의 of 요소의 타입이 codable & sendable임 그래서 sendable 설정함. 근데 지금은 안써도 작동 됨, 하지만 Document.self로 사용하려면 Sendable 꼭 사용해야 함
    let translations:[Translation]
}
