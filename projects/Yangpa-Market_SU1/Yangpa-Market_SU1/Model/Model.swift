//
//  Untitled.swift
//  YangPa-test
//
//  Created by wizard on 11/5/24.
//
import Foundation

struct Document: Codable, Identifiable{
    let id: Int
    let productName: String
    let description: String
    let price: Int
    let photo: String
    let userName: String
}

struct SaleRoot: Codable{
    let success: Bool
    let documents: [Document]
    let message: String
}

struct Member: Codable {
    let userName: String
}

struct SignUp: Codable {
    let success: Bool
    let member: Member
    let message: String
}


struct SignIn: Codable {
    let success: Bool
    let token: String
    let member: Member
    let message: String
}

struct APIError: Codable {
    let message: String
}
