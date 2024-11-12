//
//  SALES.swift
//  Yangpa-market-SwiftUI
//
//  Created by songhee jeong on 11/12/24.
//

import Foundation

struct Documents: Codable {
    var productName:String
    var description:String
    var price:Int
    var userName:String
    var photo: String
    
}
struct Sales: Codable {
    var success:Bool
    var documents:[Documents]
    var message:String
}
