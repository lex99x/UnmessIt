//
//  ResidentValidator.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/08/23.
//

import Foundation
import RealmSwift

protocol CreateResidentValidatorImpl {
    func validate(_ resident: User) throws
}

struct CreateResidentValidator: CreateResidentValidatorImpl {
    
    func validate(_ resident: User) throws {
        
        if resident.nickname.isEmpty {
            throw CreateValidatorError.emptyName
        }
        
    }
    
    func validateString(_ name:String) throws {
        if name.isEmpty {
            throw CreateValidatorError.emptyName
        }
    }
    
    func validateExistentResident(_ residents: [User], nickname: String) {
        
    }
}



extension CreateResidentValidator {
    enum CreateValidatorError: LocalizedError {
        case emptyName
        case residentExists
    }
}

extension CreateResidentValidator.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Please enter resident Name."
        
        case .residentExists:
            return "Resident already exists."
        }
    }
}

