//
//  AppDelegate.swift
//  Notification-test
//
//  Created by 정송희 on 11/21/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate { // UNUserNotificationCenterDelegate 적용해야 앱 사용중에도 보임

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:  [UIApplication.LaunchOptionsKey: Any]?) -> Bool { // 앱이 실행되고 나서 할 일(권한 받기)
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        let option = UNAuthorizationOptions(arrayLiteral: [.alert, .sound]) // .badge
        UNUserNotificationCenter.current().requestAuthorization(options: option) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications() // 1번
                }
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let info = notification.request.content.userInfo
        print(info["name"] ?? "")
        completionHandler([.banner, .sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
//        let info = userInfo
//        print(info["name"] ?? "")
//        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let info = response.notification.request.content.userInfo
        print(info["name"] ?? "")
        completionHandler()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token:String = ""
        for i in 0..<deviceToken.count {
            token += String(format:"%02.2hhx", deviceToken[i] as CVarArg)
        }
        
        print("APNS token : \(token)")
        UserDefaults.standard.set(token, forKey: "token")
    }
}

