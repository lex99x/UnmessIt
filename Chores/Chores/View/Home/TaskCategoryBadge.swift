//
//  TaskCategoryBadge.swift
//  Chores
//
//  Created by Alex A. Rocha on 18/09/23.
//

import SwiftUI

struct TaskCategoryBadge: View {
    @Environment(\.sizeCategory) var sizeCategory
    let taskCategory: TaskCategory
    
    var body: some View {
        HStack {
            Task.getTaskIconByCategory(taskCategory: taskCategory)
                .renderingMode(.original)
                .resizable()
                .frame(width: 16, height: 16)
                .minimumScaleFactor(sizeCategory.isAccessibilityCategory ? 2.0 : 1.0)
            Text(("task_type_" + taskCategory.rawValue.lowercased().replacingOccurrences(of: " ", with: "_")).localized)
                .foregroundColor(.textPrimaryColor)
            
        }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .padding(.vertical, 4)
        .background {
            Color.surfaceSecondaryColor
                .clipShape(Capsule())
        }
    }
    
}

struct TaskCategoryBadge_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryBadge(taskCategory: TaskCategory.clothes)
    }
}
