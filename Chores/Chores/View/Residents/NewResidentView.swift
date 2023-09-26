//
//  NewResidentView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 20/08/23.
//

import SwiftUI
import RealmSwift

struct NewResidentView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var newResidentViewModel = NewResidentViewModel()
    let isEditing: Bool
    let isSpaceOwner: Bool
    @State private var isShowingDeleteAlert = false
    @ObservedRealmObject var resident: User
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                
                CustomTextFieldView(title: "resident_input_name_title".localized,
                                    placeholder: "resident_input_name_placeholder".localized,
                                    isOptional: false,
                                    textfield: $newResidentViewModel.residentName)
                
                HStack {
                    
                    Text("preferences_title".localized)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimaryColor)
                    
                    Spacer()
                    
                    Text("optional".localized)
                        .foregroundColor(.textSecondaryColor)
                    
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .padding(.top, 24)
                
                ScrollView {
                    ForEach(TaskCategory.values, id: \.self) { item in
                        
                        MultipleSelectionRow(title: item.rawValue, isSelected: newResidentViewModel.selections.contains(item.rawValue)) {
                            if newResidentViewModel.selections.contains(item.rawValue) {
                                newResidentViewModel.selections.removeAll(where: { $0 == item.rawValue })
                            } else {
                                newResidentViewModel.selections.append(item.rawValue)
                            }
                        }
                        .padding(.top, (item.rawValue == TaskCategory.values.first?.rawValue) ? 8 : .zero)
                        .padding(.bottom, (item.rawValue == TaskCategory.values.last?.rawValue) ? 8 : .zero)
                        
                        if item.rawValue != TaskCategory.values.last?.rawValue {
                            Divider()
                        }
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.borderDefaultColor, lineWidth: 0.5)
                    )
                    .background(Color.surfaceSecondaryColor)
                    .cornerRadius(10)
                }
                
            }
            
            Spacer()
            
            if isEditing == true && isSpaceOwner == false {
                Button {
                    isShowingDeleteAlert.toggle()
                } label: {
                    HStack {
                        Image.userRemoveIcon
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("alert_delete_resident_title".localized)
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    }
                    .foregroundColor(.textCriticalColor)
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: nil,
                                               backgroundColor: .surfaceTertiaryColor))
            }
            
        }
        .alert("alert_delete_resident_title".localized, isPresented: $isShowingDeleteAlert, actions: {
            Button("alert_delete_resident_action_left".localized, role: .cancel) {
                isShowingDeleteAlert.toggle()
            }
            Button("alert_delete_resident_action_right".localized, role: .destructive) {
                newResidentViewModel.deleteResident(item: resident)
                dismiss()
            }
        }, message: {
            Text("alert_delete_resident_description".localized)
        })
        .alert("alert_resident_missing_fields_title".localized, isPresented: $newResidentViewModel.hasError, actions: {
//            Button("Cancel", role: .cancel) {
//                isShowingDeleteAlert.toggle()
//            }
            Button("alert_resident_missing_fields_action".localized, role: .cancel) {
                newResidentViewModel.hasError = false
            }
        }, message: {
            Text("alert_resident_missing_fields_description".localized)
        })
        .padding(.top, 12)
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("resident_button_cancel".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 16))
                        .foregroundColor(.textAccentColor)
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text(isEditing ? "edit_resident_title".localized : "new_resident_title".localized)
                    .font(Font.custom(Font.generalSansFontRegular, size: 16))
                    .foregroundColor(.textPrimaryColor)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
//                    viewModel.addNewTask()
                    print(newResidentViewModel.selections)
                    if isEditing {
                        newResidentViewModel.updateUser(item: resident)
                    } else {
                        newResidentViewModel.addResident()
                    }
                    if newResidentViewModel.hasError == false {
                        dismiss()
                    }
                }, label: {
                    Text("resident_button_save".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 16))
                        .foregroundColor(.textAccentColor)
                })
            }
            
        }
        .background {
            Color.surfaceSheetColor
                .ignoresSafeArea()
        }
        .toolbarBackground(Color.surfaceSheetColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            
            if resident.nickname.count > 0 {
                newResidentViewModel.residentName = resident.localizedNickname()
            }
            
            if resident.preferences.count > 0 {
                for item in resident.preferences {
                    newResidentViewModel.selections.append(item.rawValue)
                }
            }
            
        }
        
    }
    
}


struct MultipleSelectionRow: View {
    
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Button(action: action) {
                
                HStack {
                    
                    Image.checkIcon
                        .frame(width: 24, height: 24)
                        .foregroundColor(.textPrimaryColor)
                        .opacity(isSelected ? 1 : 0)
                  
                    Text(("task_type_" + title.lowercased().replacingOccurrences(of: " ", with: "_")).localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                    Image(title)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("Category" + title.replacingOccurrences(of: " ", with: "")))
                    
                }
                
            }
            
        }
        .padding(.vertical, 4)
        .padding(.leading, 12)
        .padding(.trailing, 16)
        .background {
            Color.surfaceSecondaryColor
        }
        
    }
    
}
