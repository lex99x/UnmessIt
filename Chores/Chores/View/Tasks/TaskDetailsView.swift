////
////  TaskDetailsView.swift
////  Chores
////
////  Created by Alex A. Rocha on 16/08/23.
////
//
//import SwiftUI
//import RealmSwift
//
//struct TaskDetailsView: View {
//    
//    let task: Task
//    
//    @State var isShowingDeleteAlert = false
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        
//        VStack(alignment: .leading, spacing: 24) {
//            
//            // MARK: Title + Description
//            VStack(alignment: .leading, spacing: 16) {
//                
//                Text(task.title)
//                    .font(Font.custom(Font.generalSansFontMedium, size: 20))
//                Text(task.desc)
//                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
//                
//            }
//            
//            // MARK: Tags
//            HStack(spacing: 8) {
//                
//                HStack {
//                    Text(task.category.rawValue)
//                        .foregroundColor(.textSecondaryColor)
//                    Image.lightCleaningIcon
//                        .resizable()
//                        .frame(width: 16, height: 16)
//                        .foregroundColor(.categoryLightCleaningColor)
//                }
//                .font(Font.custom(Font.generalSansFontRegular, size: 15))
//                .padding(.vertical, 6)
//                .padding(.horizontal, 8)
//                .inputOverlay()
//                .background {
//                    Color.surfaceSecondaryColor
//                }
//                
//                if task.isImportant {
//                    
//                    HStack {
//                        Text("Important task")
//                        Image.pinIcon
//                            .resizable()
//                            .frame(width: 16, height: 16)
//                    }
//                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
//                    .foregroundColor(.textSecondaryColor)
//                    .padding(.vertical, 6)
//                    .padding(.horizontal, 8)
//                    .inputOverlay()
//                    .background {
//                        Color.surfaceSecondaryColor
//                    }
//                    
//                }
//                
//            }
//            
//            // MARK: Time configs
//            VStack(alignment: .leading, spacing: 8) {
//                
//                HStack {
//                    
//                    HStack {
//                        Text(task.startDate.formatted(date: .abbreviated, time: .omitted))
//                        Image(systemName: "circle.fill")
//                            .resizable()
//                            .frame(width: 4, height: 4)
//                        Text(task.startDate.formatted(date: .omitted, time: .shortened))
//                    }
//                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
//                    .foregroundColor(.textPrimaryColor)
//                    
//                    Spacer()
//                    
//                    if task.endRepeatDate != nil {
//                        
//                        HStack {
//                            Text("Recurrent task")
//                            Image.repeatIcon
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                        }
//                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
//                        .foregroundColor(.textSecondaryColor)
//                        
//                    }
//                    
//                }
//                
//                if let endRepeatDate = task.endRepeatDate {
//                    
//                    Text("Repeats every \(task.repetitionNumber) \(task.repetitionTimePeriod.rawValue.lowercased()) until \(endRepeatDate.formatted(date: .abbreviated, time: .omitted))")
//                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
//                        .foregroundColor(.textSecondaryColor)
//                    
//                }
//                
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .inputOverlay()
//            .background {
//                Color.surfaceSecondaryColor
//            }
//            
//            // MARK: Schedule
//            VStack(alignment: .leading, spacing: 16) {
//                
//                Text("Schedule")
//                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
//                    .foregroundColor(.textPrimaryColor)
//                
//                VStack(spacing: 12) {
//                    
//                    ForEach(task.assignees) { assignee in
//                        
//                        VStack {
//                            
//                            HStack {
//                                Text(assignee.nickname)
//                                    .foregroundColor(.textPrimaryColor)
//                                Spacer()
//                                Text("Today")
//                                    .foregroundColor(.textSecondaryColor)
//                            }
//                            
//                            Divider()
//                            
//                        }
//                        
//                    }
//                    
//                }
//                .font(Font.custom(Font.generalSansFontRegular, size: 15))
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 10)
//                .padding(.horizontal, 12)
//                .inputOverlay()
//                .background {
//                    Color.surfaceSecondaryColor
//                }
//                
//            }
//            
//            Spacer()
//            
//        }
//        .padding(.horizontal)
//        .padding(.top, 16)
//        .navigationTitle("View task")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {}, label: {
//                    HStack {
//                        Image.arrowLeftIcon
//                        Text("Back")
//                    }
//                    .foregroundColor(.textAccentColor)
//                })
//            }
//            
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button(action: {}, label: {
//                    Image.editIcon
//                        .foregroundColor(.textAccentColor)
//                })
//                Button(action: {
//                    isShowingDeleteAlert.toggle()
//                }, label: {
//                    Image.deleteIcon
//                        .foregroundColor(.textCriticalColor)
//                })
//                .alert("Delete task", isPresented: $isShowingDeleteAlert, actions: {
//                    Button("Cancel", role: .cancel) {
//                        isShowingDeleteAlert.toggle()
//                    }
//                    Button("Delete", role: .destructive) {
//                        dismiss()
//                    }
//                }, message: {
//                    Text("This action cannot be undone.\nAre you sure you want to delete it?")
//                })
//            }
//            
//        }
//        
//    }
//}
//
//struct TaskDetailsView_Previews: PreviewProvider {
//    
//    static let mockedTask = Task(value: ["title": "Take ou the trash",
//                                         "desc": "Empty all trash cans and take it out before 14h. Don't forget that box for recycling.",
//                                         "isImportant": true,
//                                         "category": TaskCategory.ligthCleaning,
//                                         "startDate": Date.now,
//                                         "repetitionNumber": 2,
//                                         "repetitionTimePeriod": TimePeriod.days,
//                                         "endRepeatDate": Date.now] as [String : Any])
//    
//    static var previews: some View {
//        NavigationStack {
//            TaskDetailsView(task: TaskDetailsView_Previews.mockedTask)
//        }
//    }
//}
