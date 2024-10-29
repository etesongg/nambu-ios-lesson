//
//  ViewController.swift
//  MapTest
//
//  Created by 정송희 on 10/29/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2D(latitude: 37.463191, longitude: 126.905885)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: center, span: span)
//        mapView.mapType =  // 우리나라 지원 .hybrid .standard .satellite
        
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
    }

    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
//        case 1: mapView.mapType = .satellite
        case 1: mapView.preferredConfiguration = MKImageryMapConfiguration() // .satellite
        case 2: mapView.preferredConfiguration = MKHybridMapConfiguration() // .hybrid
        default: mapView.preferredConfiguration = MKStandardMapConfiguration() // .standard
        }
    }
    
    @IBAction func actShowPin(_ sender: Any) {
        let location = CLLocationCoordinate2D(latitude: 37.463191, longitude: 126.905885)
//        직접만들기
//        let pin = MKPointAnnotation()
//        pin.coordinate = location // 필수
//        pin.title = "남부여성발전센터"
//        pin.subtitle = "iOS 개발자 과정"
//        mapView.addAnnotation(pin)
        
//        customannotaion으로 만들기 // subjectClass NSObject
        let annotation = CustomAnnotaion(coordinate: location, title: "남부여성발전센터", subtitle: "iOS 풀스택", url: "https://naver.com", thumbnail: "nambu")
        mapView.addAnnotation(annotation)
        
        
    }
}

extension ViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? { // 위에서 만든 annotation을 넘겨받아서 만들어줌
        guard let annotation = annotation as? CustomAnnotaion else { fatalError()}
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") // 재활용
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            let imageView = UIImageView(image: UIImage(named: annotation.thumbnail))
            annotationView?.leftCalloutAccessoryView = imageView
            annotationView?.canShowCallout = true
        }
        annotationView?.annotation = annotation
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) { // tap 치고 맨 아래
        guard let annotation = view.annotation as? CustomAnnotaion else { return }
        print(annotation.url)
    }
}

