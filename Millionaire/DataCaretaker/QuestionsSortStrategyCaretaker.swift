//
//  QuestionsSortStrategyCaretaker.swift
//  Millionaire
//
//  Created by Anton Hodyna on 24/03/2022.
//

import Foundation

class QuestionsSortStrategyCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "questionsSort"
    
    func save(strategy: QuestionsStrategies) {
        do {
            let data = try self.encoder.encode(strategy)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrive() -> QuestionsStrategies {
        guard let data = UserDefaults.standard.data(forKey: key) else { return .sequensial }
        do {
            return try decoder.decode(QuestionsStrategies.self, from: data)
        } catch {
            print(error)
            return .sequensial
        }
    }
}
