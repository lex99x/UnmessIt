//
//  HomeView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TaskViewModel()
    
    @State private var searchText: String = ""
    @State private var isShowingDeleteAlert = false
    
    var content: Results<Task> {
        if searchText.isEmpty {
            return viewModel.tasks
        } else {
            return viewModel.tasks.where {
                $0.title.contains(searchText)
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: Empty State
            if viewModel.tasks.isEmpty {
                
                VStack {
                    
                    VStack(spacing: 24) {
                        
                        Image("EmptyState")
                            .resizable()
                            .frame(width: 199, height: 146)
                            .padding(.bottom, 56)
                        
                        Text("home_empty_title")
                            .font(Font.custom(Font.generalSansFontSemibold, size: 28))
                            .foregroundColor(.textPrimaryColor)
                        Text("home_empty_description_1")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textSecondaryColor)
                        Text("home_empty_description_2")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textSecondaryColor)
                        
                    }
                    .multilineTextAlignment(.center)
                    
                }
                .padding(.top, 64)
                .padding(.horizontal)
                
            } else {
                
                VStack {
                    List {
                        ForEach(content.freeze()) { task in
                            
                            TaskCardView(task: task)
                                .swipeActions(edge: .trailing) {
                                    if task.status == .pending {
                                        Button {
                                            viewModel.updateStatus(status: .done, item: task)
                                        } label: {
                                            VStack {
                                                Image.doneStatusIcon
                                                Text("home_task_status_done".localized)
                                                    .font(Font.custom(Font.generalSansFontMedium, size: 15))

                                            }
                                            
                                        }
                                        .tint(.surfaceSwipeDone)
                                    } else {
                                        Button {
                                            viewModel.updateStatus(status: .pending, item: task)
                                        } label: {
                                            VStack {
                                                Image.pendingStatusIcon
                                                Text("home_task_status_pending".localized)
                                                    .font(Font.custom(Font.generalSansFontMedium, size: 15))

                                            }
                                            
                                        }
                                        .tint(.surfaceSwipePending)
                                    }
                                    
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 8, leading: .zero, bottom: 8, trailing: .zero))
                            
                        }
                    }
                    .listStyle(.inset)
                }
                .searchable(text: $searchText)
                .padding(.top, 12)
                
            }
            
            Spacer()
            
            Button(action: {
                viewModel.isAddingNewTask.toggle()
            }, label: {
                Label(title: {
                    Text("home_button_add_task")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                }, icon: {
                    Image.plusIcon
                        .resizable()
                        .frame(width: 20, height: 20)
                })
                .foregroundColor(.textInvertColor)
            })
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: .textInvertColor,
                                           backgroundColor: .accentColor))
            .sheet(isPresented: $viewModel.isAddingNewTask) {
                NavigationStack {
                    NewTaskView(isEditing: false, didDeleteTask: .constant(false), task: Task())
                }
            }
            
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                NavigationLink(destination: { ManageResidentsView() }, label: {
                    Image.groupIcon
                        .resizable()
                        .foregroundColor(.textAccentColor)
                        .frame(width: 20, height: 20)
                    Text("home_manage_residents")
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textAccentColor)
                })
                
            }
            
            if !viewModel.tasks.isEmpty {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Menu {
                        Button(role: .destructive, action: callDeleteAllTasks, label: {
                            Text("home_delete_all_task")
                            Image.deleteIcon
                        })
                    } label: {
                        Button(action: {}, label: {
                            Image.moreIcon
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.textAccentColor)
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
            HomeView()
        }
    }
}
