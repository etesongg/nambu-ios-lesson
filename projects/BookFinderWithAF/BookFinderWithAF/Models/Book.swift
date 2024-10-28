//
//  Book.swift
//  BookFinderWithCodable
//
//  Created by 정송희 on 10/22/24.
//

import Foundation

struct Book:Codable { // Codable = Decodable & Encodable
    let title:String
    let publisher:String
    let authors:[String]
    let thumbnail:String
    let url:String
}

struct Meta:Codable {
    let isEnd:Bool
    let pageableCount:Int
    let totalCount:Int
    
    enum CodingKeys:String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

struct Root:Codable{
    let meta:Meta
    let Books:[Book]
    
    enum CodingKeys:String, CodingKey {
        case meta
        case Books = "documents"
        
    }
}

