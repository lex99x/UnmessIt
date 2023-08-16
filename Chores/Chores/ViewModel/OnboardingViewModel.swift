//
//  vm.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 09/08/23.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Published var userNameTextfield = ""
    @Published var selectedNotificationTime = Date.now
    @Published var placeNameTextfield = ""
    @Published var placeResidents: [String] = ["Fulano", "Ciclano", "Beltrano"]

    func registerUserName() -> String? {
        UserDefaults.standard.set(self.userNameTextfield, forKey: "userName")
        return UserDefaults.standard.string(forKey: "userName")
    }
    
}
