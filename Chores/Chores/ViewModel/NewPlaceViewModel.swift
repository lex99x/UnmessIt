//
//  CreateHomeViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import SwiftUI

class NewPlaceViewModel: ObservableObject {
    
    @Published var nameTextfield = ""
    @Published var descriptionTextfield = ""
    @Published var urlsTextfield = ""
    @Published var notesTextfield = ""
    
    @Published var files: [String] = []
    @Published var isFileOpen = false
        
}
