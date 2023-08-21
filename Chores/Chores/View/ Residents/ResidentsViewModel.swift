//
//  ResidentsViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import Foundation
import RealmSwift
import SwiftUI

final class ResidentsViewModel: ObservableObject {

        @ObservedResults(Space.self) var spaces

        private var token: NotificationToken? = nil
        private var selectedSpace: Space?
     
        @Published var residents = RealmSwift.List<User>()
        
        init() {
            selectedSpace = spaces.first
            
            if let selectedSpace = selectedSpace {
                residents = selectedSpace.residents
            }
            
            token = spaces.observe({ (changes) in
                switch changes {
                case .error(_): break
                case .initial(_): break
                case .update(_, deletions: _, insertions: _, modifications: _):
                    self.objectWillChange.send()
                }
            })
            }
        }
