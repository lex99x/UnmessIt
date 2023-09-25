//
//  TaskStatusBadge.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 07/08/23.
//

import SwiftUI

struct TaskStatusBadge: View {
    
    let status: Task.Status
    
    let statusIcon: Image
    let statusText: String
    let contentColor: Color
    let surfaceColor: Color
    
    init(status: Task.Status) {
        self.status = status
        switch status {
            case .pending:
                statusIcon = Image.pendingStatusIcon
                statusText = "home_task_status_pending".localized
                contentColor = .badgeTextPendingColor
                surfaceColor = .badgeSurfacePendingColor
            case .done:
                statusIcon = Image.doneStatusIcon
                statusText = "home_task_status_done".localized
                contentColor = .badgeTextDoneColor
                surfaceColor = .badgeSurfaceDoneColor
            case .cantDo:
                statusIcon = Image.blockedStatusIcon
                statusText = "Not done"
                contentColor = .badgeTextBlockedColor
                surfaceColor = .badgeSurfaceBlockedColor
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                statusIcon
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(contentColor)
                Text(statusText)
                    .foregroundColor(contentColor)
                    .fixedSize()
            }
            .font(Font.custom(Font.generalSansFontRegular, size: 15))
            .padding(.leading, 8)
            .padding(.trailing, 12)
            .padding(.vertical, 4)
            .background(surfaceColor)
            .cornerRadius(16)
        }
    }
    
}

struct TaskStatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        TaskStatusBadge(status: .done)
        TaskStatusBadge(status: .pending)
        TaskStatusBadge(status: .cantDo)
    }
}
