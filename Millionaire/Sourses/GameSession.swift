//
//  GameSession.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

class GameSession {
    var score = Observable<Int>(0)
    var name: String = ""
    var questionsStrategy: QuestionsStrategies? 
    var questions: [Question]?
    var persentPerQuestion: Int?
    var currentPersent = Observable<Int>(0)
    var helpsCount = 3
    var isFiftyFifty = true
    var isHallHelp = true
    var isFriendCall = true
    
    func configurePersentPerQuestion() {
        if let count = questions?.count {
            persentPerQuestion = 100 / count
        }
    }
}
