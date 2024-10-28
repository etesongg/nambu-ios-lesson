//
//  ViewController.swift
//  CLocationTest
//
//  Created by 정송희 on 10/28/24.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.allowsBackgroundLocationUpdates = true
        
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("didupdate location : \(location.coordinate.latitude): \(location.coordinate.longitude)")
        manager.stopUpdatingLocation() // didUpdateLocations안에 stopUpdatingLocation를 추가해주면 한번만 가져옴
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error \(error.localizedDescription)")
    }

}

