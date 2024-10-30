//
//  ModelData.swift
//  Landmarks
//
//  Created by 정송희 on 10/30/24.
//

import Foundation

var landmarks:[Landmark] = load("landmarkData.json")

//func load(_ filename:String) -> [Landmark]
func load<T:Decodable>(_ filename:String) -> T {
    
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("메인번들에서 \(filename) 파일을 찾을 수 없습니다.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("메인번들에서 \(filename) 파일을 읽을 수 없습니다. ")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data) // T가 [Landmark]가 됨??
    }catch{
        fatalError("\(filename) 파일을 \(T.self)로 디코딩할 수 없습니다.")
    }
    
}
