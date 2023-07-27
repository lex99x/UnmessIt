//
//  CreateHomeView.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import SwiftUI

struct CreateHomeView: View {
    
    @State var nameTextfield = ""
    @State var descriptionTextfield = ""
    @State var urlsTextfield = ""
    
    var body: some View {
        
        Divider()
                        
        VStack(alignment: .leading) {
                    
            CustomTextFieldView(title: "Name",
                                optionalLabel: nil,
                                placeholder: "Type the name of the place",
                                textfield: $nameTextfield)
            .padding(.vertical)
            
            CustomTextFieldView(title: "Description",
                                optionalLabel: "Optional",
                                placeholder: "Small description about the place",
                                textfield: $descriptionTextfield)
            .padding(.bottom)
        
            Text("Agreements, terms and rules")
                .font(.title3)
            
            CustomFilePickerView()
                .padding(.bottom)
            
            CustomTextFieldView(title: "URLs", optionalLabel: "Optional", placeholder: "Paste useful links here", textfield: $urlsTextfield)
                .padding(.bottom)
            
            CustomTextFieldView(title: "Notes", optionalLabel: "Optional", placeholder: "Add useful information about living in this place", textfield: $urlsTextfield)
                .padding(.bottom)
            
            Spacer()
            
            Button("Add place", action: {
                
            })
            .buttonStyle(CustomButtonStyle())
            
        }
        .padding(.horizontal)
        .navigationTitle("New place")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct CreateHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateHomeView()
        }
    }
}
