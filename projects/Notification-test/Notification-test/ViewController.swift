//
//  ViewController.swift
//  Notification-test
//
//  Created by 정송희 on 11/21/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actInterval(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Interval Notification Trigger"
        content.subtitle = "서브 타이틀"
        content.body = "설정하신 인터벌 노티피케이션을 알려드립니다."
        content.userInfo = ["name":"정년이"]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error {
                print("알림설정에 실패했습니다. \(error.localizedDescription)")
            }
            print("알림설정에 성공했습니다.")
        }
    }
    
    @IBAction func actCalendar(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Calender Notification Trigger"
        content.subtitle = "서브 타이틀"
        content.body = "설정하신 캘린더 노티피케이션을 알려드립니다."
        content.userInfo = ["name":"정년이"]
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // identifier: UUID().uuidString로 관리하기 귀찮다면 현재 등록되어 있는거 다 날리고 관리??
        var dataComponets = DateComponents()
        dataComponets.weekday = 1
        dataComponets.hour = 14
        dataComponets.minute = 46
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponets, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    @IBAction func actLocation(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Location Notification Trigger"
        content.subtitle = "서브 타이틀"
        content.body = "설정하신 location 노티피케이션을 알려드립니다."
        content.userInfo = ["name":"정년이"]
         
        let center = CLLocationCoordinate2D(latitude: 37, longitude: -122)
        let region = CLCircularRegion(center: center, radius: 100, identifier: "IOS class")
        region.notifyOnExit = true
        region.notifyOnEntry = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

