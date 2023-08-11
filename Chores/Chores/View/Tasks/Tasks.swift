//
//  Tasks.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI
import RealmSwift

struct Tasks: View {
    
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var searchText = ""
    //    private var a: Results
    
    //    var searchResults: RealmSwift.List<Task>  {
    //        if searchText.isEmpty {
    //            return viewModel.tasks
    //        } else {
    //
    //            return viewModel.tasks.where{$0.title.contains(searchText)}
    //
    //        }
    //    }
    //
    var body: some View {
        
        ZStack {
            
            if viewModel.tasks.isEmpty {
                
                VStack(spacing: 56) {
                    VStack {
                        Text("It's so quiet and empty in here...")
                        Text("Add a few tasks to your routine")
                            .padding(.bottom, 24)
                            .padding(.top, 4)
                    }
                    .foregroundColor(.gray)
                    
                    Button("Add task", action: {
                        // TODO: add navigation to add new task
//                        viewModel.addNewTask()
                        viewModel.isAddingNewTask.toggle()
                    })
                    .buttonStyle(CustomButtonStyle(width: .infinity,
                                                   foregroundColor: .white,
                                                   backgroundColor: .btnDarkBackground))
                }
                .padding()
                
            } else {
                VStack {
                    List {
                        Section {
                            ForEach(viewModel.tasks.freeze()) { item in
                                TaskItem(item: item)
                                    .listRowSeparator(.hidden)
                                    .swipeActions(edge: .trailing) {
                                        
                                        Button {
                                            viewModel.realm!.resolve(ThreadSafeReference(to: item))!.updateStatus(status: .done)
                                            
                                            print("aaa")
                                        } label: {
                                            Text("DONE")
                                        }.tint(.green)
                                    }
                                
                                    .swipeActions(edge: .leading) {
                                        
                                        Button {
                                            viewModel.realm!.resolve(ThreadSafeReference(to: item))!.updateStatus(status: .cantDo)
                                            
                                            print("aaa")
                                        } label: {
                                            Text("notDone")
                                        }
                                        .tint(.red)
                                    }
                                
                                
                            }
                            .onDelete { IndexSet in
                                viewModel.delete(at: IndexSet)
                            }
                            
                        }
                        
                        
                    }
                    .listStyle(.inset)
                    
                    Button("Add task", action: {
                        // TODO: add navigation to add new task
//                        viewModel.addNewTask()
                        viewModel.isAddingNewTask.toggle()
                    })
                    .buttonStyle(CustomButtonStyle(width: .infinity,
                                                   foregroundColor: .white,
                                                   backgroundColor: .btnDarkBackground))
                    .padding()
                    .sheet(isPresented: $viewModel.isAddingNewTask) {
                        NavigationStack {
                            NewTaskView()
                        }
                    }
                    
                }
                .searchable(text: $searchText)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Place Name")
                    .fontWeight(.bold)
            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {}, label: {
//                    Image(systemName: "ellipsis.circle")
//                })
//            }
        }
        
    }
    
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Tasks()
        }
    }
}
