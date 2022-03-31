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
    var questions: [Question]?
    var persentPerQuestion: Int?
    var currentPersent = Observable<Int>(0)
    var helpsCount = 3
    var isFiftyFifty = true
    var isHallHelp = true
    var isFriendCall = true
    var actualQuestionFacade: ActualQuestionFacade?
    
    func configurePersentPerQuestion() {
        if let count = questions?.count {
            persentPerQuestion = 100 / count
        }
    }
    
    func configureActualQuestion() {
        guard let questions = questions, !questions.isEmpty, let question = questions.first else { return actualQuestionFacade = nil}
        actualQuestionFacade = ActualQuestionFacade(question: question)
    }
    
    func getQuestions(questionsStrategy: QuestionsStrategies) {
        switch questionsStrategy {
        case .random:
            questions =  RandomQuestionSortStrategy().createQuestionsArray()
        case .sequensial:
            questions = SequentialQuestionsSortStrategy().createQuestionsArray()
        }
    }
    
    func firstConfigure(questionsStrategy: QuestionsStrategies) {
        getQuestions(questionsStrategy: questionsStrategy)
        configurePersentPerQuestion()
        configureActualQuestion()
    }
}
