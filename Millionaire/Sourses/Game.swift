//
//  Game.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

class Game {
    
    let recordsCaretaker = RecordsCaretaker()
    
    static let shared = Game()
    
    private(set) var records: [Record] = [] {
        didSet {
            recordsCaretaker.save(records: records)
        }
    }
    
    private init() {
        records = recordsCaretaker.retrive()
    }
    
    var name: String?
    var gameSession: GameSession?

    
    
    func addRecord(record: Record) {
        records.append(record)
    }
    
    func clearRecords() {
        records = []
    }
}
