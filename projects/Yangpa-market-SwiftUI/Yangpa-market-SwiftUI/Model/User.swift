//
//  User.swift
//  Yangpa-market-SwiftUI
//
//  Created by songhee jeong on 11/12/24.
//

import Foundation

struct Member:Codable {
    var userName:String
}

struct User: Codable {
    var success:Bool
    var token:String
    var member:Member
    var message:String
}
