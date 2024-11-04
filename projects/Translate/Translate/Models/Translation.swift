//
//  Translation.swift
//  Translate
//
//  Created by songhee jeong on 11/4/24.
//

struct Translation: Codable {
    let text: String
    let to: String
}

struct TranslationResult: Codable {
    let translations: [Translation]
    
    enum CodingKeys: String, CodingKey { // 다른 데이터는 무시하고 case에 있는 것만 처리하세요
        case translations
    }
}
