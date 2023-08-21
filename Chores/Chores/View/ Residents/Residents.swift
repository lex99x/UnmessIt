//
//  Residents.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift

struct Residents: View {
    @ObservedObject private var residentsViewModel = ResidentsViewModel()
    
    var body: some View {
        List {
            ForEach(residentsViewModel.residents) { item in
                Text(item.nickname)
                
            }
        }
    }
}

struct Residents_Previews: PreviewProvider {
    static var previews: some View {
        Residents()
            .environment(\.realm, RealmHelper.realmA())
    }
}
