//
//  Landmark.swift
//  Landmarks
//
//  Created by 정송희 on 10/30/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    var park:String
    var state:String
    var description:String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
