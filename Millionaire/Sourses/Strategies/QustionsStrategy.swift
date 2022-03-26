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
        return [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion].shuffled()
    }
    
}

class SequentialQuestionsSortStrategy: DefaultQuestions, QuestionsSortStrategy {
    func createQuestionsArray() -> [Question] {
        return [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion]
    }
}
