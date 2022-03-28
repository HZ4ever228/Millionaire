//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import Foundation

class QuestionBuilder {
    
    let game = Game.shared
    
    private(set) var question: String = ""
    private(set) var firstAnswer: String = ""
    private(set) var secondAnswer: String = ""
    private(set) var thirdAnswer: String = ""
    private(set) var fourthAnswer: String = ""
    
    func addQuestion(_ question: String) {
        self.question = question
    }
    
    func addFirstAnswer(_ firstAnswer: String) {
        self.firstAnswer = firstAnswer
    }
    
    func addSecondAnswer(_ secondAnswer: String) {
        self.secondAnswer = secondAnswer
    }
    
    func addThirdAnswer(_ thirdAnswer: String) {
        self.thirdAnswer = thirdAnswer
    }
    
    func addFourthAnswer(_ fourthAnswer: String) {
        self.fourthAnswer = fourthAnswer
    }
    
    func isQuestionReadyForBuild() -> Bool {
        if self.question.isEmpty || self.firstAnswer.isEmpty || self.secondAnswer.isEmpty || self.thirdAnswer.isEmpty || self.fourthAnswer.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func build(correctAnswer: Int) -> Question {
        var answer = ""
        switch correctAnswer {
        case 0:
            answer = self.firstAnswer
        case 1:
            answer = self.secondAnswer
        case 2:
            answer = self.thirdAnswer
        case 3:
            answer = self.fourthAnswer
        default:
            break
        }
        let question = Question(question: self.question,
                                firstAnswer: self.firstAnswer,
                                secondAnswer: self.secondAnswer,
                                thirdAnswer: self.thirdAnswer,
                                fourthAnswer: self.fourthAnswer,
                                correctAnswer: answer)
        return question
    }
    
}
