//
//  Tasks.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI
import RealmSwift

struct Tasks: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = TaskViewModel()
//    @State private var selection: String? = nil
    @State var searchText: String = ""
    @State var isShowingDeleteAlert = false
    @State private var filterTimeInterval = 0
    
    //    var filtered: Results<Task> {
    //        if filterTimeInterval == 0 {
    //            return viewModel.tasks.where {
    //                $0.createdAt.timeIntervalSinceNow =
    //            }
    //        } else if filterTimeInterval == 1 {
    //            return viewModel.tasks.where {
    //                $0.createdAt < Date()
    //            }
    //        }
    //        else if filterTimeInterval == 3 {
    //            return viewModel.tasks.where {
    //                $0.createdAt > Date()
    //            }
    //        } else {
    //            return viewModel.tasks
    //        }
    //    }
    
    var content: Results<Task>{
        if searchText.isEmpty {
            return viewModel.tasks
        }else {
            return viewModel.tasks.where {
                $0.title.contains(searchText)
            }
        }
        
    }
    
    var body: some View {
        
        VStack {
            
//            NavigationLink(destination: Residents(), tag: "A", selection: $selection) { EmptyView() }
            
            if viewModel.tasks.isEmpty {
                
                VStack {
                    
                    VStack(spacing: 24) {
                        
                        Image("EmptyState")
                            .resizable()
                            .frame(width: 199, height: 146)
                            .padding(.bottom, 56)
                        
                        Text("It's so quiet in here...")
                            .font(Font.custom(Font.generalSansFontSemibold, size: 28))
                            .foregroundColor(.textPrimaryColor)
                        Text("To set up your preferences or add the people who live with you, tap “Manage residents”")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textSecondaryColor)
                        Text("To add a few tasks to your routine, tap the button below “Add a task”")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textSecondaryColor)
                        
                    }
                    .multilineTextAlignment(.center)
                    
                }
                .padding(.top, 64)
                .padding(.horizontal)
                                
            } else {
                
                VStack {
                    
//                    MARK: Segmented Filter
//                    VStack {
//                        Picker("What is your favorite color?", selection: $filterTimeInterval) {
//                            Text("Yesterday").tag(1)
//                            Text("Today").tag(0)
//                            Text("Tomorrow").tag(2)
//                        }
//                    }
//                    .padding()
//                    .pickerStyle(.segmented)
                    
                    List {
                        Section {
                            ForEach(content.freeze()) { item in
                                TaskRow(item: item)
                                    .padding(.bottom, 8)
                                    .listRowSeparator(.hidden)
                                    .swipeActions(edge: .trailing) {
                                        
                                        Button {
                                            viewModel.updateStatus(status: .done, item: item)
                                            print("aaa")
                                        } label: {
                                            Text("DONE")
                                        }.tint(.green)
                                    }
                            }
                        }
                        
                        
                    }
                    .listStyle(.inset)
                    
                }
                .searchable(text: $searchText)
                
            }
            
            Spacer()
            
            Button(action: {
                viewModel.isAddingNewTask.toggle()
            }, label: {
                Label(title: { Text("Add a task") }, icon: { Image.plusIcon })
            })
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: .textInvertColor,
                                           backgroundColor: .accentColor))
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.isAddingNewTask) {
                NavigationStack {
                    NewTaskView(isEditing: false, task: Task())
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Tasks")
                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
                    .foregroundColor(.textPrimaryColor)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                NavigationLink(destination: { Residents() }, label: {
                    Image.userAddIcon
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Manage residents")
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                })
                
            }
            
            if !viewModel.tasks.isEmpty {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Menu {
                        Button(role: .destructive, action: callDeleteAllTasks, label: {
                            Text("Delete all tasks")
                                .tint(.red)
                            Image.deleteIcon
                                .foregroundColor(.red)
                        })
                    } label: {
                        Button(action: {}, label: {
                            Image.moreIcon
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.textPrimaryColor)
                        })
                    }
                    .alert("alert_delete_all_tasks_title".localized, isPresented: $isShowingDeleteAlert, actions: {
                        Button("alert_delete_all_tasks_action_left".localized, role: .cancel) {
                            isShowingDeleteAlert.toggle()
                        }
                        Button("alert_delete_all_tasks_action_right".localized, role: .destructive) {
                            viewModel.deleteAll()
                            dismiss()
                        }
                    }, message: {
                        Text("alert_delete_all_tasks_description".localized)
                    })
                    
                }
                
            }
            
        }
        .toolbarBackground(Color.surfaceSecondaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            
//            print(viewModel.selectedSpace?.residents.count)
            
            if viewModel.selectedSpace?.residents.count == 0 {
                viewModel.registerOwner()
            }
            
        }
        
    }
    
    private func callDeleteAllTasks() {
        isShowingDeleteAlert.toggle()
    }
    
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Tasks()
        }
    }
}

