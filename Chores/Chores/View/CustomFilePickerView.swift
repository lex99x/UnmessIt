//
//  CustomFilePickerView.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomFilePickerView: View {
    
    @State var fileName: String?
    @State var isFilePickerOpen = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Label(
                    title: { Text("Attach files...") },
                    icon: { Image(systemName: "paperclip") }
                )
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1.0)
            )
            .onTapGesture {
                isFilePickerOpen.toggle()
            }
            
            Text("You can attach PDFs (up to 1MB) and images up to (1MB)")
                .font(.footnote)
                .foregroundColor(.gray)
            
        }
        .fileImporter(isPresented: $isFilePickerOpen, allowedContentTypes: [.pdf], allowsMultipleSelection: false, onCompletion: { result in
            
            do {
                
                let fileUrl = try result.get()
                print(fileUrl)
                self.fileName = fileUrl.first?.lastPathComponent ?? nil
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
//        .onChange(of: fileName, perform: { newValue in
//            print(fileName!)
//        })
        
    }
    
}

struct CustomFilePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFilePickerView()
            .padding()
    }
}
