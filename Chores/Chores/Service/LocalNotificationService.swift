//
//  NotificationService.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 31/07/23.
//

import Foundation
import UserNotifications


final class LocalNotificaitonService {
    static let shared = LocalNotificaitonService()
    private let authSigned = UserDefaults.standard.bool(forKey: "notificationAuthSigned")
    
    
    func requestAuth() -> Void {
        if !authSigned {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    UserDefaults.standard.set(true, forKey: "notificationAuthSigned")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func schedule( notificaitonBody:LocalNotificationBody ) {
        if authSigned {
            let content = UNMutableNotificationContent()
            content.title = notificaitonBody.title
            content.subtitle = notificaitonBody.subtitle
            content.sound = UNNotificationSound.default
            
            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificaitonBody.timeInterval, repeats: notificaitonBody.repeats)
            
            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
}
