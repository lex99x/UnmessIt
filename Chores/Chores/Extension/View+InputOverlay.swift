//
//  View+InputFieldOverlay.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

extension View {
    func inputOverlay() -> some View {
        return modifier(InputOverlayModifier())
    }
}

struct InputOverlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.borderDefaultColor, lineWidth: 0.5)
            }
            .background {
                Color.surfaceSecondaryColor
                    .cornerRadius(8)
            }
    }
}
