//
//  TaskDetailsView.swift
//  Chores
//
//  Created by Alex A. Rocha on 16/08/23.
//

import SwiftUI

struct TaskDetailsView: View {
    
    let task: Task
    
    @State var isImportantTask = true // temp
    
    @State var isShowingDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            VStack(spacing: 16) {
                
                HStack {
                    Text("Take out the trash")
                        .font(Font.custom(Font.generalSansFontMedium, size: 20))
                    Spacer()
                }
                
                Text("Empty all trash cans and take it out before 14h. Don't forget that box for recycling.")
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                
            }
            
            HStack(spacing: 8) {
                
                HStack {
                    Text("Light cleaning")
                    Image(systemName: "pencil")
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
                        Image(systemName: "pin")
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .inputOverlay()
                    .background {
                        Color.surfaceSecondaryColor
                    }
                    
                }
                
            }
            
            VStack(spacing: 16) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        HStack {
                            Text("10 Aug 2023")
                            Text("●")
                            Text("12:00")
                        }
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .foregroundColor(.textPrimaryColor)
                        Spacer()
                        HStack {
                            Text("Recurrent task")
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textSecondaryColor)
                    }
                    
                    Text("Repeats every 2 days until 23 Sep 2023")
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textSecondaryColor)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
                
            }
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Schedule")
                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
                    .foregroundColor(.textPrimaryColor)
                
                VStack(spacing: 12) {
                    
                    VStack {
                        
                        HStack {
                            HStack {
                                Image(systemName: "person")
                                Text("Fulano de tal")
                            }
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .foregroundColor(.textPrimaryColor)
                            Spacer()
                            Text("Today")
                                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                .foregroundColor(.textSecondaryColor)
                        }
                        
                        Divider()
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            HStack {
                                Image(systemName: "person")
                                Text("Fulano de tal")
                            }
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .foregroundColor(.textPrimaryColor)
                            Spacer()
                            Text("Today")
                                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                .foregroundColor(.textSecondaryColor)
                        }
                        
                        Divider()
                        
                    }
                    
                }
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
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "pencil.circle")
                })
                .foregroundColor(.textInvertColor)
                Button(action: {
                    isShowingDeleteAlert.toggle()
                }, label: {
                    Image(systemName: "trash")
                })
                .foregroundColor(.textInvertColor)
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
