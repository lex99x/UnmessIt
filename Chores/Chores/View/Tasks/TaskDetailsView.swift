//
//  TaskDetailsView.swift
//  Chores
//
//  Created by Alex A. Rocha on 16/08/23.
//

import SwiftUI

struct TaskDetailsView: View {
    
    let task: Task
    
    @State var isImportantTask = true // MARK: temp
    
    @State var isShowingDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            // MARK: Title + Description
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Take out the trash")
                    .font(Font.custom(Font.generalSansFontMedium, size: 20))
                
                Text("Empty all trash cans and take it out before 14h. Don't forget that box for recycling.")
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                
            }
            
            // MARK: Tags
            HStack(spacing: 8) {
                
                HStack {
                    Text("Light cleaning")
                        .foregroundColor(.textSecondaryColor)
                    Image.lightCleaningIcon
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.categoryLightCleaningColor)
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
                
                if isImportantTask {
                    
                    HStack {
                        Text("Important task")
                        Image.pinIcon
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textSecondaryColor)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .inputOverlay()
                    .background {
                        Color.surfaceSecondaryColor
                    }
                    
                }
                
            }
            
            // MARK: Time configs
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    
                    HStack {
                        Text("10 Aug 2023")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                        Text("12:00")
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    .foregroundColor(.textPrimaryColor)
                    
                    Spacer()
                    
                    HStack {
                        Text("Recurrent task")
                        Image.repeatIcon
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textSecondaryColor)
                    
                }
                
                Text("Repeats every 2 days until 23 Sep 2023")
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textSecondaryColor)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .inputOverlay()
            .background {
                Color.surfaceSecondaryColor
            }
            
            // MARK: Schedule
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Schedule")
                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
                    .foregroundColor(.textPrimaryColor)
                
                VStack(spacing: 12) {
                    
                    VStack {
                        
                        HStack {
                            Text("Fulano de tal")
                                .foregroundColor(.textPrimaryColor)
                            Spacer()
                            Text("Today")
                                .foregroundColor(.textSecondaryColor)
                        }
                        
                        Divider()
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            Text("Fulano de tal")
                                .foregroundColor(.textPrimaryColor)
                            Spacer()
                            Text("Today")
                                .foregroundColor(.textSecondaryColor)
                        }
                        
                        Divider()
                        
                    }
                    
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
                
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .navigationTitle("View task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}, label: {
                    HStack {
                        Image.arrowLeftIcon
                        Text("Back")
                    }
                    .foregroundColor(.textAccentColor)
                })
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    Image.editIcon
                        .foregroundColor(.textAccentColor)
                })
                Button(action: {
                    isShowingDeleteAlert.toggle()
                }, label: {
                    Image.deleteIcon
                        .foregroundColor(.textCriticalColor)
                })
                .alert("Delete task", isPresented: $isShowingDeleteAlert, actions: {
                    Button("Cancel", role: .cancel) {
                        isShowingDeleteAlert.toggle()
                    }
                    Button("Delete", role: .destructive) {
                        dismiss()
                    }
                }, message: {
                    Text("This action cannot be undone.\nAre you sure you want to delete it?")
                })
            }
            
        }
        
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskDetailsView(task: Task())
        }
    }
}
