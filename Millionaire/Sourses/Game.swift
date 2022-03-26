//
//  Game.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

class Game {
    
    let recordsCaretaker = RecordsCaretaker()
    let nameCaretaker = NameCaretaker()
    let questionsSortStrategyCaretaker = QuestionsSortStrategyCaretaker()
    
    static let shared = Game()
    
    private(set) var records: [Record] = [] {
        didSet {
            recordsCaretaker.save(records: records)
        }
    }
    
    private(set) var name: String = "" {
        didSet {
            nameCaretaker.save(name: name)
        }
    }
    
    private(set) var questionsStrategy: QuestionsStrategies = .sequensial {
        didSet {
            questionsSortStrategyCaretaker.save(strategy: questionsStrategy)
        }
    }
    
    private init() {
        records = recordsCaretaker.retrive()
        name = nameCaretaker.retrive()
        questionsStrategy = questionsSortStrategyCaretaker.retrive()
    }
    
    
    var gameSession: GameSession?
    
    func addRecord(record: Record) {
        records.append(record)
    }
    
    func clearRecords() {
        records = []
    }
    
    func setName(newName: String) {
        name = newName
    }
    
    func changeQustionSortStrategy(strategy: QuestionsStrategies) {
        questionsStrategy = strategy
    }
}
