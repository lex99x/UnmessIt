//
//  OnboardViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 08/08/23.
//

import Foundation
import SwiftUI


import SwiftUI

class OnboardViewModel: ObservableObject {
    
    @Published var userNameTextfield = ""

    
    func registerUserName() -> String? {
        UserDefaults.standard.set(self.userNameTextfield, forKey: "userName")
        return UserDefaults.standard.string(forKey: "userName")
    }
}
