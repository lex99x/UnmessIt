//
//  Color+Hex.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 03/08/23.
//

import SwiftUI

extension Color {
    
    // MARK: Text colors
    static let textAccentColor = Color("TextAccent")
    static let textPrimaryColor = Color("TextPrimary")
    static let textSecondaryColor = Color("TextSecondary")
    static let textCriticalColor = Color("TextCritical")
    static let textInvertColor = Color("TextInvert")
    
    // MARK: Surface colors
    static let surfacePrimaryColor = Color("SurfacePrimary")
    static let surfaceSecondaryColor = Color("SurfaceSecondary")
    static let surfaceTertiaryColor = Color("SurfaceTertiary")
    static let surfaceQuaternaryColor = Color("SurfaceQuaternary")
    static let surfaceButtonSecondaryColor = Color("SurfaceButtonSecondary")
    static let surfaceAccentPrimaryColor = Color("SurfaceAccentPrimary")
    static let surfaceSheetColor = Color("SurfaceSheet")
    
    // MARK: Categories colors
    static let categoryClothesColor = Color("CategoryClothes")
    static let categoryCookingColor = Color("CategoryCooking")
    static let categoryHeavyCleaningColor = Color("CategoryHeavyCleaning")
    static let categoryLightCleaningColor = Color("CategoryLightCleaning")
    static let categoryOrganizationColor = Color("CategoryOrganization")
    static let categoryPaymentsColor = Color("CategoryPayments")
    static let categoryShoppingColor = Color("CategoryShopping")
    static let categoryPetsColor = Color("CategoryPets")
    static let categoryDogColor = Color("CategoryDog")
    static let categoryCatColor = Color("CategoryCat")
    
    // MARK: Border colors
    static let borderDefaultColor: Color = Color("BorderDefault")
    static let borderFocusColor: Color = Color("BorderFocus")
    
    // MARK: Badge colors
    static let badgeTextDoneColor = Color("BadgeTextDone")
    static let badgeTextPendingColor = Color("BadgeTextPending")
    static let badgeTextBlockedColor = Color("BadgeTextBlocked")

    static let badgeSurfaceDoneColor = Color("BadgeSurfaceDone")
    static let badgeSurfacePendingColor = Color("BadgeSurfacePending")
    static let badgeSurfaceBlockedColor = Color("BadgeSurfaceBlocked")
    
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
    
    static let doneTaskBadgeText = Color(hex: "67B173")
    static let doneTaskBadgeBackground = Color(hex: "67B173").opacity(0.15)
    
    static let notDoneTaskBadgeText = Color(hex: "FF5252")
    static let notDoneTaskBadgeBackground = Color(hex: "FF5252").opacity(0.15)
    
    static let taskTypeBackgroudn = Color(hex: "DADBF7")
    static let taskRowBackground = Color(hex: "D6D6D6").opacity(0.5)
    
    static let surfaceSurfaceSecondary: Color = Color(hex:"F5F5F5")
    
    static let surfaceAccentPrimary: Color = Color(hex:"6DD6E4")
    static let accent2: Color = Color(hex: "079AAD")
    static let defaultRed: Color = Color(hex: "ED3A4C")
    
    static let text_criticalText = Color(hex: "FF6B7A")
    static let surface_surfaceTetriary = Color(hex: "242424")
}

extension CGColor {    
    static let taskTypeBackgroudn = Color(hex: "DADBF7")
}
