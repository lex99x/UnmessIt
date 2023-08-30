//
//  ResidentValidator.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/08/23.
//

import Foundation

protocol CreateResidentValidatorImpl {
    func validate(_ resident: User) throws
}

struct CreateResidentValidator: CreateResidentValidatorImpl {
    
    func validate(_ resident: User) throws {
        
        if resident.nickname.isEmpty {
            throw CreateValidatorError.emptyName
        }
        
    }
}

extension CreateResidentValidator {
    enum CreateValidatorError: LocalizedError {
        case emptyName
    }
}

extension CreateResidentValidator.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Please enter resident Name."
        }
    }
}

