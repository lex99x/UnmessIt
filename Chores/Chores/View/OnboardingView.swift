//
//  Onboard.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 09/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var viewModel = OnboardingViewModel()
    
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
            
            CustomTextFieldView(title: "How would you like to be called?",
                                placeholder: "Type your name or nickname",
                                isOptional: false,
                                textfield: $viewModel.userNameTextfield)
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
                                           backgroundColor: Color.accentColor))
            
            Spacer()
            
        }
        .padding(.horizontal)
        
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
            
            NavigationLink(destination: Tasks(), label: {
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

struct OnboardingNewPlaceView: View {
    
    @Binding var placeNameTextfield: String
    
    @State var residentNameTextfield = ""
    @State var isResidentTextfieldVisible = false
    @FocusState var isResidentTextfieldFocused: Bool
    
    @State var isPlaceResidentEmpty = true
    
    @Binding var placeResidents: [String]
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Text("New place")
                .font(Font.custom(Font.generalSansFontSemibold, size: 28))
                .padding(.top, 120)
            
            Text("Now add your place to UnmessIt and register who lives that live with you, unless you live alone.")
                .font(Font.custom(Font.generalSansFontRegular, size: 17))
                .foregroundColor(Color.textSecondaryColor)
                .fixedSize(horizontal: false, vertical: true)
            
            CustomTextFieldView(title: "Place's name",
                                placeholder: "Give a name to this place",
                                isOptional: false,
                                textfield: $placeNameTextfield)
            //            .padding(.top, 41)
            
            HStack {
                Text("Residents")
                Spacer()
            }
            
            VStack {
                
                if isResidentTextfieldVisible {
                    
                    HStack {
                        
                        TextField("Resident's name", text: $residentNameTextfield)
                            .focused($isResidentTextfieldFocused)
                            .onSubmit {
                                placeResidents.append(residentNameTextfield)
                                isPlaceResidentEmpty = false
                                print(placeResidents)
                                residentNameTextfield = ""
                            }
                        
                        Button(action: {
                            isResidentTextfieldVisible = false
                            isResidentTextfieldFocused = false
                        }, label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(Color.textPrimaryColor)
                        })
                        //                        .disabled(placeResidents.isEmpty)
                        
                    }
                    
                } else {
                    
                    Button(action: {
                        isResidentTextfieldVisible = true
                        isResidentTextfieldFocused = true
                    }, label: {
                        
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Add resident")
                            Spacer()
                        }
                        .foregroundColor(Color.textPrimaryColor)
                        
                    })
                    
                }
                
            }
            .padding()
            .inputOverlay()
            
            if isPlaceResidentEmpty {
                
                List {
                    
                    ForEach(placeResidents, id: \.self) { resident in
                        Text(resident)
                    }
                    .onDelete(perform: { offsets in
                        placeResidents.remove(atOffsets: offsets)
                        if placeResidents.isEmpty {
                            isPlaceResidentEmpty = true
                        }
                        print(placeResidents)
                    })
                    
                }
                .listStyle(.plain)
                .inputOverlay()
                
                Spacer()
                
                NavigationLink(destination: EmptyView(), label: {
                    Text("Get started")
                })
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: nil,
                                               backgroundColor: Color.accentColor))
                
            }
            
        }
        .padding(.horizontal)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var viewModel = OnboardingViewModel()
        NavigationStack {
            OnboardingView()
        }
        OnboardingNotificationsView(selectedNotificationTime: .constant(Date.now))
            .previewDisplayName("Onboarding Notifications View")
        OnboardingNewPlaceView(placeNameTextfield: $viewModel.placeNameTextfield,
                               placeResidents: $viewModel.placeResidents)
        .previewDisplayName("Onboarding New Place View")
    }
}
