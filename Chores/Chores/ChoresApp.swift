//
//  ChoresApp.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI

@main
struct ChoresApp: App {
    let notificationService = LocalNotificaitonService.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NewTaskView()
            }
//            .onAppear {
//                // MARK: Daily notification time
//
//                if notificationService.getPendingRequestsCount() == 0 {
//
//                    // MARK: fetch data to schedule tomorrow notification
//
//
//
//                }
//            }
        }
    }
}
