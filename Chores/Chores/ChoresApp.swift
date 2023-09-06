//
//  ChoresApp.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI
import RealmSwift

@main
struct ChoresApp: SwiftUI.App {
    
//    let notificationService = LocalNotificaitonService.shared
    @ObservedResults(Space.self) var spaces
    
    var body: some Scene {
        WindowGroup {
            if let space = spaces.first  {
                NavigationStack {
                    Tasks()
                }
            } else {
                ProgressView()
                    .onAppear {
                        $spaces.append(Space())
                    }
            }
        }
    }
    
}
