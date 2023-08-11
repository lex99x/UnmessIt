//
//  CoordinatorView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 09/08/23.
//

import SwiftUI

struct CoordinatiorView: View {
    @StateObject private var coordinator = Coordinator()
    
    private var starterPage: Page
    
    init() {
        if (UserDefaults.standard.string(forKey: "userName") != nil) {
            self.starterPage = .tasks
        } else {
            self.starterPage = .onboarding
        }
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: self.starterPage)
                .navigationDestination(for: Page.self) { page  in
                    coordinator.build(page: page)
                }
//                .sheet(item: $coordinator.sheet) { sheet in
//                    coordinator.build(sheet: sheet)
//                }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatiorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatiorView()
    }
}
