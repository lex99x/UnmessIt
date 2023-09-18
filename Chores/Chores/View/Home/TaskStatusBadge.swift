//
//  TaskStatusBadge.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 07/08/23.
//

import SwiftUI

struct TaskStatusBadge: View {
    
    @State var status: Task.Status
    
    let colors: (Color, Color)
    let content: (icon: Image, text: String)
    
    init(status: Task.Status) {
        self.status = status
        switch status {
            case .pending:
                self.colors = (.badgeTextPendingColor, .badgeSurfacePendingColor)
                self.content = (Image.pendingStatusIcon, "home_task_status_pending".localized)
            case .done:
                self.colors = (.doneTaskBadgeText, .doneTaskBadgeBackground)
                self.content = (Image.doneStatusIcon, "home_task_status_done".localized)
            case .cantDo:
                self.colors = (.notDoneTaskBadgeText, .notDoneTaskBadgeBackground)
                self.content = (Image.blockedStatusIcon, "Not done")
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                self.content.0
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(self.colors.0)
                Text(self.content.1)
                    .foregroundColor(self.colors.0)
                    .fixedSize()
            }
            .font(Font.custom(Font.generalSansFontRegular, size: 15))
            .padding(.leading, 8)
            .padding(.trailing, 12)
            .padding(.vertical, 4)
            .background(self.colors.1)
            .cornerRadius(16)
        }
    }
    
}

struct TaskStatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        TaskStatusBadge(status: .done)
        TaskStatusBadge(status: .pending)
    }
}
