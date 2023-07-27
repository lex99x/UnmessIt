//
//  CreateHomeView.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import SwiftUI

struct CreateHomeView: View {
    
    @ObservedObject var viewModel = CreateHomeViewModel()
    
    var body: some View {
        
        Divider()
        
        VStack(alignment: .leading, spacing: 25) {
            
            CustomTextFieldView(title: "Name",
                                optionalLabel: nil,
                                placeholder: "Type the name of the place",
                                textfield: $viewModel.nameTextfield)
            .padding(.top, 10)
            
            CustomTextFieldView(title: "Description",
                                optionalLabel: "Optional",
                                placeholder: "Small description about the place",
                                textfield: $viewModel.descriptionTextfield)
            
            Text("Agreements, terms and rules")
                .font(.title3)
            
            CustomFilePickerView()
            
            CustomTextFieldView(title: "URLs", optionalLabel: "Optional", placeholder: "Paste useful links here", textfield: $viewModel.urlsTextfield)
            
            CustomTextFieldView(title: "Notes", optionalLabel: "Optional", placeholder: "Add useful information about living in this place", textfield: $viewModel.notesTextfield)
            
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
