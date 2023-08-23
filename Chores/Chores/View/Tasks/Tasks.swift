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
    @State private var selection: String? = nil
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
            NavigationLink(destination: Residents(), tag: "A", selection: $selection) { EmptyView() }
            
            if viewModel.tasks.isEmpty {
                
                Spacer()
                
                VStack(spacing: 56) {
                    VStack(alignment: .center) {
                        Text("It's so quiet in here...")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("To set up your preferences or add the people who live with you, tap “Manage residents”")
                            .padding()
                        Text("To add a few tasks to your routine, tap the button below “Add a task”")
                            .padding()
                    }
                    .multilineTextAlignment(.center)
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    .foregroundColor(.textSecondaryColor)
                }
                
                Spacer()
                
                Button(action: {
                    // TODO: add navigation to add new task
//                    viewModel.isAddingNewTask.toggle()
                    viewModel.add()
                }, label: {
                    Label(title: { Text("Add a task") }, icon: { Image.plusIcon })
                })
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .textInvertColor,
                                               backgroundColor: .accentColor))
                .padding(.horizontal)
                .padding(.bottom, 8)
//                .sheet(isPresented: $viewModel.isAddingNewTask) {
//                    NavigationStack {
////                        NewTaskView()
//                        Text("New task view")
//                    }
//                }
                
            } else {
                VStack {
                    // MARK: Segmented Filter
//                    VStack {
//                        Picker("What is your favorite color?", selection: $filterTimeInterval) {
//                            Text("Yesterday").tag(1)
//                            Text("Today").tag(0)
//                            Text("Tomorrow").tag(2)
//                        }
//                    }
//                    .padding()
//                    .pickerStyle(.segmented)
//
                    List {
                        Section {
                            ForEach(content.freeze()) { item in
                                TaskRow(item: item)
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
                                        
                    Button(action: {
                        // TODO: add navigation to add new task
    //                    viewModel.isAddingNewTask.toggle()
                        viewModel.add()
                    }, label: {
                        Label(title: { Text("Add a task") }, icon: { Image.plusIcon })
                    })
                    .buttonStyle(CustomButtonStyle(width: .infinity,
                                                   foregroundColor: .textInvertColor,
                                                   backgroundColor: .accentColor))
                    .padding()
                    .sheet(isPresented: $viewModel.isAddingNewTask) {
                        NavigationStack {
//                            NewTaskView()
                            Text("add new task")
                        }
                    }
                    
                }
                .searchable(text: $searchText)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("My Place")
                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    selection = "A"
//                    print(viewModel.selectedSpace?.residents ?? ["fodasse"])
                } label: {
                    Image.userAddIcon
                    Text("Manage residents")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Menu {
                    Button(role: .destructive ,action: callDeleteAllTasks, label: {
                        Text("Delete all Tasks")
                            .tint(.red)
                        Image.deleteIcon
                            .foregroundColor(.red)
                    })
                } label: {
                            Button(action: {}, label: {
                                Image.moreIcon
                                    .foregroundColor(.textPrimaryColor)
                            })
                            
                }
                
                // delete all alert
                .alert("Delete task", isPresented: $isShowingDeleteAlert, actions: {
                    Button("Cancel", role: .cancel) {
                        isShowingDeleteAlert.toggle()
                    }
                    Button("Delete All", role: .destructive) {
                        viewModel.deleteAll()
                        dismiss()
                    }
                }, message: {
                    Text("This action cannot be undone.\nAre you sure you want to delete it?")
                })
                
            }
            
        }
        
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.red, for: .automatic)
        
        .onAppear {
            print("apareceu")
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

