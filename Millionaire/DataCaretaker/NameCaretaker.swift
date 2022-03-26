//
//  NameCaretaker.swift
//  Millionaire
//
//  Created by Anton Hodyna on 24/03/2022.
//

import Foundation

class NameCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "name"
    
    func save(name: String) {
        do {
            let data = try self.encoder.encode(name)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrive() -> String {
        guard let data = UserDefaults.standard.data(forKey: key) else { return "" }
        do {
            return try decoder.decode(String.self, from: data)
        } catch {
            print(error)
            return ""
        }
    }
}
