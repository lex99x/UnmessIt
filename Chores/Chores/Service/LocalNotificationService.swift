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
    
    
    func requestAuth() -> Void {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    UserDefaults.standard.set(true, forKey: "notificationAuthSigned")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    
    func schedule( notificaitonBody:LocalNotificationBody ) {
        let content = UNMutableNotificationContent()
            
        content.title = notificaitonBody.title
        content.subtitle = notificaitonBody.subtitle
            
        content.sound = UNNotificationSound.default
            
        
        switch notificaitonBody.frequency {
        case .none:
            print("none")
        case .daily:
            var date = DateComponents()

            date.hour = 10

            date.minute = 30

            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
        }
    
    
    
    func getPendingRequestsCount() -> Int {
        var requestCount = 0
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("Count: \(notifications.count)")
            requestCount = notifications.count
        }
        return requestCount
    }
    
}
