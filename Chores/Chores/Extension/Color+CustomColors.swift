//
//  Color+Hex.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI

extension Color {
    static let textPrimaryColor = Color("TextPrimary")
    static let textAccentColor = Color("TextAccent")
    static let textCriticalColor = Color("TextCritical")
    static let textSecondaryColor = Color("TextSecondary")
    static let textInvertColor = Color("TextInvert")
    static let surfaceButtonSecondaryColor = Color("SurfaceButtonSecondary")
    static let surfaceSecondaryColor = Color("SurfaceSecondary")
    static let categoryLightCleaningColor = Color("CategoryLightCleaning")
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
    static let taskRowBackground = Color(hex: "D6D6D6").opacity(0.5)
    
    static let surfaceSurfaceSecondary: Color = Color(red: 0.96, green: 0.96, blue: 0.96)
    static let borderBorderDefault: Color = Color(red: 0.84, green: 0.84, blue: 0.84)
    
}

extension CGColor {
//    static let backgroundCGColor = Color.backgroundColor.cgColor
    
    static let taskTypeBackgroudn = Color(hex: "DADBF7")
}
