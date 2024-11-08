//
//  Blog.swift
//  BookFinderWithSwiftUI
//
//  Created by wizard on 5/16/24.
//

import Foundation



extension String {
    func asAttributedString() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        ).string
    }
}

struct Blog: Codable, Identifiable {
    var title:String
    var contents:String
    var blogname:String
    var thumbnail:String
    var url:String
    var id:String

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title).asAttributedString()!
        self.contents = try container.decode(String.self, forKey: .contents).asAttributedString()!
        self.blogname = try container.decode(String.self, forKey: .blogname)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.url = try container.decode(String.self, forKey: .url)
        self.id = UUID().uuidString
    }
    
    init(title: String, contents: String, blogname: String, thumbnail: String, url: String, id: String) {
        self.title = title
        self.contents = contents
        self.blogname = blogname
        self.thumbnail = thumbnail
        self.url = url
        self.id = id
    }
}

struct BlogMeta: Codable {
    var isEnd:Bool
    enum CodingKeys:String, CodingKey{
        case isEnd = "is_end"
    }
}

struct BResult: Codable {
    var meta: BlogMeta
    var blogs: [Blog]
    
    enum CodingKeys:String, CodingKey{
        case meta
        case blogs = "documents"
    }
}
