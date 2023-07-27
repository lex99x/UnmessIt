//
//  CreateHomeViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import SwiftUI

class CreateHomeViewModel: ObservableObject {
    
    @Published var nameTextfield = ""
    @Published var descriptionTextfield = ""
    @Published var urlsTextfield = ""
    @Published var notesTextfield = ""
    
    @Published var fileName = ""
    @Published var isFileOpen = false
    
    
}
