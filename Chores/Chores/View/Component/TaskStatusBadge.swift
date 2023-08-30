//
//  TaskStatusBadge.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 07/08/23.
//

import SwiftUI

struct TaskStatusBadge: View {
//    enum Status {
//        case pending, done, notDone
//    }
//
    
    @State var status: Task.Status
    
    let colors: (Color, Color)
    let content: (icon: String, text: String)
    
    init(status: Task.Status) {
        self.status = status
        switch status {
        case .pending:
            self.colors = (.pendingTaskBadgeTextColor, .pendingTaskBadgeBackgroundColor)
            self.content = ("exclamationmark.circle", "Pending")
        case .done:
            self.colors = (.doneTaskBadgeText, .doneTaskBadgeBackground)
            self.content = ("checkmark.circle", "Done")
        case .cantDo:
            self.colors = (.notDoneTaskBadgeText, .notDoneTaskBadgeBackground)
            self.content = ("circle.slash", "Not done")
        }
    }
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Image(systemName: self.content.0)
                    .foregroundColor(self.colors.0)
                Text(self.content.1)
                    .foregroundColor(self.colors.0)
            }
            .padding(.leading, 6)
            .padding(.trailing, 8)
            .padding(.vertical, 4)
            .background(self.colors.1)
            .cornerRadius(16)
        }
    }
}
