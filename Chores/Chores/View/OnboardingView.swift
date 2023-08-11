//
//  Onboard.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 09/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var viewModel = OnboardViewModel()
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Text("Welcome to UnmessIt")
                .font(Font.custom(Font.generalSansFontSemibold, size: 28))
                .multilineTextAlignment(.center)
                .padding(.top, 120)
            
            Text("We will help you organize your household's chores. Let's get started, but first...")
                .font(Font.custom(Font.generalSansFontRegular, size: 17))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.textSecondaryColor)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal)
            
            CustomTextFieldView(title: "How would you like to be called?",
                                optionalLabel: nil,
                                placeholder: "Type your name or nickname",
                                textfield: $viewModel.userNameTextfield)
            .padding(.horizontal)
            .padding(.top, 128)
            
            NavigationLink(destination: OnboardingNotificationsView(selectedNotificationTime: $viewModel.selectedNotificationTime), label: {
                HStack {
                    Text("Next")
                    Image(systemName: "arrow.right")
                }
            })
            .disabled(viewModel.userNameTextfield.isEmpty)
            .opacity(viewModel.userNameTextfield.isEmpty ? 0.5 : 1)
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: nil,
                                           backgroundColor: Color.surfaceButtonSecondaryColor))
            .padding(.horizontal)
            
            Spacer()
            
        }
        
    }
    
}

struct OnboardingNotificationsView: View {
    
    @Binding var selectedNotificationTime: Date
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Text("Notifications")
                .font(Font.custom(Font.generalSansFontSemibold, size: 28))
                .padding(.top, 120)
            
            Text("You can set up a time of the day to receive our notifications to remind you about pending chores.")
                .font(Font.custom(Font.generalSansFontRegular, size: 17))
                .foregroundColor(Color.textSecondaryColor)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading) {
                
                Text("When would you like to get our reminders?")
                Text(selectedNotificationTime.formatted(date: .omitted, time: .shortened))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        Color.surfaceSecondaryColor
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                DatePicker("", selection: $selectedNotificationTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.surfaceSecondaryColor
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
            .padding(.top, 105)
            
            Spacer()
                        
            Button(action: {
                // implement navigation
            }, label: {
                Text("Get started")
            })
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: nil,
                                           backgroundColor: Color.accentColor))
            
            Spacer()
            
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        
    }

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
        OnboardingNotificationsView(selectedNotificationTime: .constant(Date.now))
            .previewDisplayName("Onboarding Notifications View")
    }
}
