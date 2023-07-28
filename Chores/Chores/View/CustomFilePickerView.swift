//
//  CustomFilePickerView.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomFilePickerView: View {
    
    @Binding var files: [String]
    @State var isFilePickerOpen = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                
                ForEach(files, id: \.self) { file in
                    
                    HStack {
                        
                        Label(
                            title: { Text(file) },
                            icon: { Image(systemName: getFileIconByFormat(file: file) ?? "doc") }
                        )
                        
                        Spacer()
                        
                        Button(action: {
                            removeFileFromArray(file: file)
                        }, label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.gray)
                        })
                        
                    }
                
                    Divider()
                    
                }
                
                HStack {
                    
                    Label(
                        title: { Text("Attach files...") },
                        icon: { Image(systemName: "paperclip") }
                    )
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    isFilePickerOpen.toggle()
                }
                .fileImporter(isPresented: $isFilePickerOpen, allowedContentTypes: [.pdf, .image], allowsMultipleSelection: false, onCompletion: { result in
                    addFileToArray(fileImporterResult: result)
                })
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1.0)
            )
            
            Text("You can attach PDFs (up to 1 MB) and images up to (1 MB)")
                .font(.footnote)
                .foregroundColor(.gray)
            
        }
        
    }
    
    func addFileToArray(fileImporterResult: Result<[URL], Error>) {
        
        do {
            
            guard let fileUrl = try fileImporterResult.get().first else { return }
            let fileName = fileUrl.lastPathComponent
            
            if !files.contains(fileName) {
                files.append(fileName)
                print(fileName)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func removeFileFromArray(file: String) {
        
        guard let index = files.firstIndex(of: file) else { return }
        
        files.remove(at: index)
        
    }
    
    func getFileIconByFormat(file: String) -> String? {
        
        guard let format = file.split(separator: ".").last else { return nil }
        
        switch format {
                
            case "pdf": return "doc"
            default: return "photo"
                
        }
    }
    
}

struct CustomFilePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFilePickerView(files: .constant([]))
            .padding()
    }
}
