//
//  Utils.swift
//  PListTest
//
//  Created by 정송희 on 10/21/24.
//

import UIKit
import UniformTypeIdentifiers

// 주어진 파일 이름을 기반으로 문서 디렉토리 내에 해당 파일의 URL을 반환
func urlWithFileName(_ fileName:String, type:UTType = .propertyList)-> URL{ // _ 외부매개변수명 생략, type의 기본형 설정
    let fileManger = FileManager.default // 인스턴스가 있으면 참조하고 없으면 만들어줌
    let documentsURLs = fileManger.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsURL = documentsURLs[0]
    let fileURL = documentsURL.appendingPathComponent(fileName, conformingTo: type)
    return fileURL
}
