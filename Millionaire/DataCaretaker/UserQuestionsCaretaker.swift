//
//  UserQuestionsCaretaker.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import Foundation

class UserQuestionsCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "userQuestions"
    
    func save(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrive() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
