//
//  TaskValidator.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/08/23.
//


import Foundation

protocol CreateTaskValidatorImpl {
    func validate(_ task: Task) throws
}

struct CreateTaskValidator: CreateTaskValidatorImpl {
    
    func validate(_ task: Task) throws {
        
        if task.title.isEmpty {
            throw CreateValidatorError.emptyTitle
        }
        
        if task.category == .none {
            throw CreateValidatorError.emptyCategory
        }
        
    }
}

extension CreateTaskValidator {
    enum CreateValidatorError: LocalizedError {
        case emptyCategory
        case emptyTitle
    }
}

extension CreateTaskValidator.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .emptyCategory:
            return "Please choose one category"
        case .emptyTitle:
            return "Please insert a title"
        }
    }
}
