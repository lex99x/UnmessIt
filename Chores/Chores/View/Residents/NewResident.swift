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
                    .font(.title3)
                
                ResidentInputView(residentName: $newResidentViewModel.residentName)
                
                Text("preferences_title".localized)
                    .font(.title3)
                
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
//                        .background(Color(hex: "303030"))
                        .background(Color(hex: "303030"))
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
                        Text("alert_delete_resident_title".localized)
                        
                    }
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .surface_surfaceTetriary,
                                               backgroundColor: .text_criticalText))
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
//                    Button("Cancel", role: .cancel) {
//                        isShowingDeleteAlert.toggle()
//                    }
            Button("alert_resident_missing_fields_action".localized, role: .cancel) {
                newResidentViewModel.hasError = false
            }
        }, message: {
            Text("alert_resident_missing_fields_description".localized)
        })
        
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle(isEditing ? "edit_resident_title".localized : "new_resident_title".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("resident_button_cancel".localized)
                })
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
                })
            }
            
        }
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

//
//struct NewResident_Previews: PreviewProvider {
//    static var previews: some View {
//    
//            Group {
////                NavigationView {
//                NewResident(isEditing: false, isSpaceOwner: false, resident: User())
//                        .previewDisplayName("New User")
//                    
//                    let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking"]])
//                    NewResident(isEditing: true, resident: user)
//                        .previewDisplayName("Filled")
//
////                }
//            }
//            
//                
//        }
//    }


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        ZStack{
            Button(action: self.action) {
                HStack {
                    if self.isSelected {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "F5F5F5"))
                    }
                    Text(self.title.localized)
                        .foregroundColor(Color(hex: "F5F5F5"))
    //                    .padding([.leading],50)
                    Spacer()
                    Image(self.title)
                        .renderingMode(.original)
                }
                
            }
        }
        .padding()
//        .background(Color(hex: "303030"))

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

