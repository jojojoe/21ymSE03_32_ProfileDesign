//
//  AppDelegate.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

import UIKit
import AppTrackingTransparency


//com.proiartt.aiclikes
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.applicationIconBadgeNumber = -1
//        NotificationCenter.default.addObserver(self, selector: #selector(applicDidBecomeActiveNotifi(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        HightLigtingHelper.default.initSwiftStoryKit()
        NotificationCenter.default.post(name: .didFinishLaunching, object: nil)
        
        registerNotifications(application)
        
        
        
        
        return true
    }
    func trackeringAuthor() {
       
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: {[weak self] status in
//                guard let `self` = self else {return}
//
//            })
//        }
    }
    
    @objc func applicDidBecomeActiveNotifi(_ notifi: Notification) {
        // Start the SDK (start the IDFA timeout set above, for iOS 14 or later)
        trackeringAuthor()
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


}

extension AppDelegate {
    // ????????????????????????
    func registerNotifications(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                    if (result) {
                        if !(error != nil) {
                            // ????????????
                            DispatchQueue.main.async {
                                application.registerForRemoteNotifications()
                            }
                        }
                    } else {
                        //?????????????????????
                    }
                }
            } else if (setting.authorizationStatus == .denied){
                // ????????????????????????
            } else if (setting.authorizationStatus == .authorized){
                // ??????????????????????????????dt???
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                // ????????????
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let body = notification.request.content.body
        notification.request.content.userInfo
        print(body)
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("222222")
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
//        if (categoryIdentifier.contains(localCategoryNotificationId)) {
//            // UNNotificationAction???UNTextInputNotificationAction
//            if response.actionIdentifier.contains("cancelAction") {
//                
//            }
//        }
 
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
}
