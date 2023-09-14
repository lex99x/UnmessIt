//
//  Coordinator.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 09/08/23.
//
import Foundation
import SwiftUI


enum Page: String, Identifiable {
    case // onboarding, addPlace,
         tasks
    
    var id: String {
        self.rawValue
    }
}


enum Sheet: String, Identifiable {
    case sheet
    
    var id: String {
        self.rawValue
    }
}


class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    @Published var sheet: Sheet?
    
    
    func push(_ page:Page) {
        path.append(page)
    }
    
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
//        case .onboarding:
//            OnboardingView()
//        case .addPlace:
//            NewPlaceView()
        case .tasks:
            HomeView()
        }
    }
    
    
    
//    @ViewBuilder
//    func build(sheet: Sheet) -> some View {
//        switch sheet {
//        case .sheet:
//            SheetView()
//        }
//    }
}
