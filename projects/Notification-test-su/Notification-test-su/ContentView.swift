//
//  ContentView.swift
//  Notification-test-su
//
//  Created by 정송희 on 11/21/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Interval Notification") {
                intervalTrigger()
            }
            Button("Calender Notification") {
                calenderTrigger()
            }
            Button("Location Notification") {
                
            }
        }.onAppear(perform: {
            requestNotificationPermission()
        })
        .padding()
    }
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("알림 권한이 허용되었습니다.")
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
    }
    
    func intervalTrigger(){
        let content = UNMutableNotificationContent()
        content.title = "Interval Notification Trigger"
        content.subtitle = "서브 타이틀"
        content.body = "로컬 알림 바디"
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
    
    func calenderTrigger(){
        let content = UNMutableNotificationContent()
        content.title = "Calender Notification Trigger"
        content.subtitle = "서브 타이틀"
        content.body = "설정하신 캘린더 노티피케이션을 알려드립니다."
        content.userInfo = ["name":"정년이"]
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // identifier: UUID().uuidString로 관리하기 귀찮다면 현재 등록되어 있는거 다 날리고 관리??
        var dataComponets = DateComponents()
//        dataComponets.weekday = 1
        dataComponets.hour = 15
        dataComponets.minute = 19
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponets, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func locationTrriger(){
       
    }
}

#Preview {
    ContentView()
}
