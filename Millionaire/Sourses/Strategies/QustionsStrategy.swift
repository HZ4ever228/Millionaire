//
//  QustionsStrategy.swift
//  Millionaire
//
//  Created by Anton Hodyna on 24/03/2022.
//

import UIKit

protocol QuestionsSortStrategy {
    func createQuestionsArray() -> [Question]
}

class RandomQuestionSortStrategy: DefaultQuestions, QuestionsSortStrategy {
    func createQuestionsArray() -> [Question] {
        let userQustions = Game.shared.userQustions
        let defaultQuestions = [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion]
        if !userQustions.isEmpty {
            return (defaultQuestions + userQustions).shuffled()
        } else {
            return defaultQuestions.shuffled()
        }
    }
    
}

class SequentialQuestionsSortStrategy: DefaultQuestions, QuestionsSortStrategy {
    func createQuestionsArray() -> [Question] {
        let userQustions = Game.shared.userQustions
        let defaultQuestions = [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion]
        if !userQustions.isEmpty {
            return defaultQuestions + userQustions
        } else {
            return defaultQuestions
        }
    }
}
