//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import Foundation

class QuestionBuilder {
    private(set) var questions: [Question] = []
    private(set) var question: String = ""
    private(set) var firstAnswer: String = ""
    private(set) var secondAnswer: String = ""
    private(set) var thirdAnswer: String = ""
    private(set) var fourthAnswer: String = ""
    private(set) var correctAnswer: String = ""
    
    func build() {
        let question = Question(question: question,
                        firstAnswer: firstAnswer,
                        secondAnswer: secondAnswer,
                        thirdAnswer: thirdAnswer,
                        fourthAnswer: fourthAnswer,
                        correctAnswer: correctAnswer)
        questions.append(question)
    }
    
    func buildQustionsArray() -> [Question] {
        return questions
    }
    
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
    
    func addCorrectAnswer(_ correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
}
