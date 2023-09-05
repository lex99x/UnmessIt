//
//  CreateHomeView.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import SwiftUI

struct NewPlaceView: View {
    
    @ObservedObject var viewModel = NewPlaceViewModel()
    
    var body: some View {
        
        Divider()
        
        VStack(alignment: .leading, spacing: 24) {
            
            CustomTextFieldView(title: "Name",
                                placeholder: "Type the name of the place",
                                isOptional: false,
                                textfield: $viewModel.nameTextfield)
            .padding(.top, 10)
            
            CustomTextFieldView(title: "Description",
                                placeholder: "Small description about the place",
                                isOptional: true,
                                textfield: $viewModel.descriptionTextfield)
            
            Text("Agreements, terms and rules")
                .font(.title3)
            
            CustomFilePickerView(files: $viewModel.files)
            
            CustomTextFieldView(title: "URLs",
                                placeholder: "Paste useful links here",
                                isOptional: false,
                                textfield: $viewModel.urlsTextfield)
            
            CustomTextFieldView(title: "Notes",
                                placeholder: "Add useful information about living in this place",
                                isOptional: false,
                                textfield: $viewModel.notesTextfield)
            
            Spacer()
            
            Button("Add place", action: {
            })
            .buttonStyle(CustomButtonStyle(width: .infinity, foregroundColor: .white, backgroundColor: Color(red: 0.18, green: 0.21, blue: 0.28)))
            
        }
        .padding(.horizontal)
        .navigationTitle("New place")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct NewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewPlaceView()
        }
    }
}
