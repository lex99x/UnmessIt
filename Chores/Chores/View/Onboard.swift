//
//  Onboard.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 08/08/23.
//

import SwiftUI

struct Onboarding: View {
    @ObservedObject var viewModel = OnboardViewModel()
    var body: some View {
        VStack(spacing:24) {
            Text("Welcome to UnmessIt")
                .font(
                    Font.custom("SF Pro Display", size: 28)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.44, green: 0.49, blue: 0.59))
            
            Text("We will help you organize your household's chores. Let's get started, but first...")
                .font(Font.custom("Inter", size: 17))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.44, green: 0.49, blue: 0.59))
                .frame(maxWidth: .infinity, alignment: .top)
                .padding([.leading,.trailing])
            
            
            
            CustomTextFieldView(title: "How would you like to be called?",
                                optionalLabel: nil,
                                placeholder: "Your name or nickname",
                                textfield: $viewModel.userNameTextfield)
            .padding([.trailing, .leading])
            .padding(.top, 48)
            
            Button("Get Started", action: {
                // regiter username on defaults
//                viewModel.registerUserName()
                print(viewModel.registerUserName())
                
                // implement navigation
                
            })
            .buttonStyle(CustomButtonStyle(width: .infinity, foregroundColor: .white, backgroundColor: Color(red: 0.18, green: 0.21, blue: 0.28)))
            .padding([.trailing, .leading])
            .disabled(viewModel.userNameTextfield.isEmpty)
            .opacity(viewModel.userNameTextfield.isEmpty ? 0.4 : 1)
            
        }
        
        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
