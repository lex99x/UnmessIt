//
//  ChoresApp.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI

@main
struct ChoresApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PlacesView()
            }
        }
    }
}
