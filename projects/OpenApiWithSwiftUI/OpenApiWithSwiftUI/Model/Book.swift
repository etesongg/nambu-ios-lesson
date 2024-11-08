//
//  Book.swift
//  BookFinderWithSwiftUI
//
//  Created by wizard on 5/10/24.
//

import Foundation

struct Book: Codable, Identifiable {
    var title:String
    var publisher:String
    var authors:[String]
    var thumbnail:String
    var url:String
    var price:Int
    var id:String
    
    enum CodingKeys:String, CodingKey{
        case title, publisher, authors, thumbnail, url, price
        case id = "isbn"
    }
}

struct Meta: Codable {
    var isEnd:Bool
    enum CodingKeys:String, CodingKey{
        case isEnd = "is_end"
    }
}

struct BookRoot: Codable {
    var meta: Meta
    var books: [Book]
    
    enum CodingKeys:String, CodingKey{
        case meta
        case books = "documents"
    }
}
