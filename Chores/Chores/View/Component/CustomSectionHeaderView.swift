//
//  CustomSectionHeaderView.swift
//  Chores
//
//  Created by Alex A. Rocha on 08/08/23.
//

import SwiftUI

struct CustomSectionHeaderView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color(red: 0.29, green: 0.33, blue: 0.41))
            .font(.custom("SF Pro Text", size: 17).weight(.medium))
            .offset(x: -20)
    }
}

struct CustomSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section(header: CustomSectionHeaderView(text: "Header")) {
                Text("Content...")
            }
            .headerProminence(.increased)
        }
    }
}
