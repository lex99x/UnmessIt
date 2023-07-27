//
//  CustomButtonStyle.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .bold(true)
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                Color(red: 0.18, green: 0.21, blue: 0.28)
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button title", action: {})
            .buttonStyle(CustomButtonStyle())
            .padding()
    }
}
