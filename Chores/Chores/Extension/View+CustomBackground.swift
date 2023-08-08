//
//  View+customBackground.swift
//  Chores
//
//  Created by Alex A. Rocha on 01/08/23.
//

import SwiftUI

extension View {
    func customBackground() -> some View {
        return modifier(CustomBackgroundModifier())
    }
}

struct CustomBackgroundModifier: ViewModifier {
    
    let color = Color(red: 0.97, green: 0.98, blue: 0.99)
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                color
                    .ignoresSafeArea()
            }
            .toolbarBackground(color, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
}
