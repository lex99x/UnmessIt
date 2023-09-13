//
//  NewResident.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 20/08/23.
//

import SwiftUI
import RealmSwift

struct NewResident: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var newResidentViewModel = NewResidentViewModel()
    let isEditing: Bool
    let isSpaceOwner: Bool
    @State private var isShowingDeleteAlert = false
    @ObservedRealmObject var resident: User
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text("resident_input_name_title".localized)
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimaryColor)
                
                ResidentInputView(residentName: $newResidentViewModel.residentName)
                
                HStack {
                    
                    Text("preferences_title".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimaryColor)
                    
                    Spacer()
                    
                    Text("optional".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textSecondaryColor)
                    
                }
                
                ZStack {
                    
                    ScrollView {
                        ForEach(TaskCategory.values, id: \.self) { item in
                            MultipleSelectionRow(title: item.rawValue, isSelected: newResidentViewModel.selections.contains(item.rawValue)) {
                                if newResidentViewModel.selections.contains(item.rawValue) {
                                    newResidentViewModel.selections.removeAll(where: { $0 == item.rawValue })
                                }
                                else {
                                    newResidentViewModel.selections.append(item.rawValue)
                                }
                            }
                            if item.rawValue != TaskCategory.values.last?.rawValue {
                                Divider()
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.borderDefaultColor, lineWidth: 3)
                        )
//                        .foregroundColor(Color.accent2)
                        .background(Color.surfaceSecondaryColor)
                        .cornerRadius(10)
                    }
//                    .foregroundColor(Color.accent2)
                    
                }
                
            }
            
            if isEditing == true && isSpaceOwner == false {
                Spacer()
                Button {
                    isShowingDeleteAlert.toggle()
                } label: {
                    HStack {
                        Image.userRemoveIcon
                            .frame(width: 20, height: 20)
                        Text("edit_resident_button_delete")
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.textCriticalColor)
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: nil,
                                               backgroundColor: .surfaceTertiaryColor))
            }
            
        }
        .alert("alert_delete_resident_title".localized, isPresented: $isShowingDeleteAlert, actions: {
            Button("alert_delete_resident_tasks_action_left".localized, role: .cancel) {
                isShowingDeleteAlert.toggle()
            }
            Button("alert_delete_resident_tasks_action_right".localized, role: .destructive) {
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
        .padding(.top, 26)
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("resident_button_cancel".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .fontWeight(.medium)
                        .foregroundColor(.textAccentColor)
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text(isEditing ? "edit_resident_title".localized : "new_resident_title".localized)
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
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
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .fontWeight(.medium)
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
                newResidentViewModel.residentName = resident.nickname
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
        ZStack{
            Button(action: self.action) {
                HStack {
                    if self.isSelected {
                        Image.checkIcon
                            .frame(width: 24, height: 24)
                    }
                    Text(self.title.localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    Spacer()
                    Image(self.title)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("Category" + self.title.replacingOccurrences(of: " ", with: "")))
                }
                
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 6)
        .background {
            Color.surfaceSecondaryColor
        }
//        .overlay(
//          RoundedRectangle(cornerRadius: 5)
//            .stroke(Color.borderDefaultColor, lineWidth: 3)
//        )
    }
}

struct ResidentInputView: View {
    
    var residentName: Binding<String>
    
    var body: some View {
        
        VStack {
            VStack {
                TextField("Resident name", text: residentName)
            }
        }
        .padding()
        .inputOverlay()
        
    }
    
}
