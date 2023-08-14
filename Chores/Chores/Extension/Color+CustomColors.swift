//
//  Color+Hex.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI

extension Color {
    static let textSecondaryColor = Color("TextSecondaryColor")
    static let surfaceButtonSecondaryColor = Color("SurfaceButtonSecondaryColor")
    static let surfaceSecondaryColor = Color("SurfaceSecondaryColor")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    static let btnDarkBackground = Color(red: 0.18, green: 0.21, blue: 0.28)
    static let lightModeTaskcardBackground = Color(hex: "EDEEFA")
    
    static let pendingTaskBadgeText = Color(hex: "FE9D35")
    static let pendingTaskBadgeBackground = Color(hex: "FE9D35").opacity(0.15)
    
    static let doneTaskBadgeText = Color(hex: "67B173")
    static let doneTaskBadgeBackground = Color(hex: "67B173").opacity(0.15)
    
    static let notDoneTaskBadgeText = Color(hex: "FF5252")
    static let notDoneTaskBadgeBackground = Color(hex: "FF5252").opacity(0.15)
    
    static let taskTypeBackgroudn = Color(hex: "DADBF7")
}

extension CGColor {
//    static let backgroundCGColor = Color.backgroundColor.cgColor
    
    static let taskTypeBackgroudn = Color(hex: "DADBF7")
}
