//
//  PlacesView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct PlacesView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    VStack {
                        Text("Hi there!")
                            .padding(.bottom, 24)
                        Text("To get started, add a place you live")
                            .padding(.bottom, 24)
                    }
                    .foregroundColor(.gray)
                    Button("Add place", action: {
                    })
                    .buttonStyle(CustomButtonStyle(width: 188, foregroundColor: .black, backgroundColor: Color(red: 0.93, green: 0.94, blue: 0.97)))
                }
                .padding(.top, 78)
                
                Spacer()
                
            }
            .navigationTitle("Places")
            .navigationBarTitleDisplayMode(.inline)
            //        .toolbar {
            //            Button(action: {}, label: {
            //                Image(systemName: "plus")
            //            })
            //        }
            
        }
        
    }
    
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack{
            PlacesView()
//        }
    }
}
