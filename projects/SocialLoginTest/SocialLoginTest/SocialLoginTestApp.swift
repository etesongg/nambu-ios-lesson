//
//  SocialLoginTestApp.swift
//  SocialLoginTest
//
//  Created by 정송희 on 11/26/24.
//

import SwiftUI
import KakaoSDKCommon

@main
struct SocialLoginTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate:NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        KakaoSDK.initSDK(appKey: "~~~")
        return true
    }
}
