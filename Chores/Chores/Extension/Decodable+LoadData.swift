//
//  Struct+LoadData.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import Foundation

extension Decodable {
    func loadData<T: Codable>(_ data: Data, completion: @escaping (T?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            completion(decoded)
        } catch {
            completion(nil)
        }
    }
}



