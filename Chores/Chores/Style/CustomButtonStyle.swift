//
//  CustomButtonStyle.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    let width: CGFloat
    let foregroundColor: Color?
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .bold(true)
            .frame(maxWidth: width)
            .padding()
            .background {
                backgroundColor
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button title", action: {})
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: nil,
                                           backgroundColor: .blue))
            .padding()
    }
}
