//
//  Model.swift
//  Yangpa-market
//
//  Created by 정송희 on 11/6/24.
//

import Foundation

struct Member: Codable {
    let userName: String
}

struct SignUp: Codable {
    let success:Bool
    let member:Member
    let message:String
}

struct SignIn: Codable {
    let success:Bool
    let token:String
    let member:Member
    let message:String
}

// add sale
struct Document: Codable {
    let id: Int
    let productName:String
    let description:String
    let price: Int
    let photo:String
    let userName:String
}

struct SalesResult: Codable {
    let success:Bool
    let documents:[Document]
    let message:String
}
