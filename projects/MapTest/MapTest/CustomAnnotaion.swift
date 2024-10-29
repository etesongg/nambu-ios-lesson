//
//  CustomAnnotaion.swift
//  MapTest
//
//  Created by 정송희 on 10/29/24.
//

import UIKit
import MapKit

class CustomAnnotaion: NSObject, MKAnnotation { // MKAnnotation 적용
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let url:String
    let thumbnail:String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, url: String, thumbnail: String) { // 위에 설정한 후 init하면 알아서 만들어줌
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.thumbnail = thumbnail
    }
    

}
