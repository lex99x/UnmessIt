//
//  CustomFilePickerView.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomFilePickerView: View {
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Label(
                    title: { Text("Attach files...") },
                    icon: { Image(systemName: "paperclip") }
                )
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1.0)
            )
            
            Text("You can attach PDFs (up to 1MB) and images up to (1MB)")
                .font(.footnote)
                .foregroundColor(.gray)
            
        }
        
    }
    
}

struct CustomFilePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFilePickerView()
            .padding()
    }
}
