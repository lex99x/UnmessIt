//
//  String+localized.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 31/08/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
